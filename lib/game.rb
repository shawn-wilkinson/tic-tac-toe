require_relative "player.rb"
require_relative "view.rb"
require_relative "board.rb"


class Game

  attr_accessor :type

  def initialize
    @board = Board.new
    @playera = Player.new
    @playerb = Player.new
    @player1 = Player.new
    @player2 = Player.new
    @type = nil
    @view = View
    @most_recent__move = nil
  end

  def start_game
    @view.welcome_message
    set_up_game
    play_game
  end

  def set_up_game
    establish_game_type
    enter_player_names
    select_markers
    determine_game_order
  end

  def enter_player_names
    if @playera.type == "human"
      @playera.name = @view.get_player_name
    else
      @playera.name = @view.get_computer_name
    end
    if @playerb.type == "human"
      @playerb.name = @view.get_player_name
    else
      @playerb.name = @view.get_computer_name
    end
  end

  def select_markers
    @playera.marker = get_unique_marker(@playera.name)
    @playerb.marker = get_unique_marker(@playerb.name)
  end

  def establish_game_type
    set_game_type
    set_player_types
  end

  def set_game_type
    until @type
      @view.select_game_type_message
      input = gets.chomp
      if input == '1'
        @type = "human vs computer"
        @view.game_type_message(@type)
      elsif input == '2'
        @type = "human vs human"
        @view.game_type_message(@type)
      elsif input == '3'
        @type = "computer vs computer"
        @view.game_type_message(@type)
      else
        @view.invalid_game_type_message
      end
    end
  end

  def set_player_types
    if @type == "human vs computer"
      @playera.type = "human"
      @playerb.type = "computer"
    elsif @type == "human vs human"
      @playera.type = "human"
      @playerb.type = "human"
    else
      @playera.type = "computer"
      @playerb.type = "computer"
    end
  end

  def determine_game_order
    while true
      @view.who_plays_first_message(@playera.name,@playerb.name)
      order_preference = gets.chomp
      break if order_preference == "1" || order_preference == "2"
      @view.invalid_first_player_message
    end
    if order_preference == '1'
      @player1 = @playera
      @player2 = @playerb
    else
      @player1 = @playerb
      @player2 = @playera
    end
  end

  def get_unique_marker(name)
    digits = ["0","1","2","3","4","5","6","7","8","9"]
    @view.select_marker_message(name)
    while true
      input = gets.chomp
      if (input.length == 1) && (input != @player1.marker) && (input != @player2.marker) && (!digits.include?(input))
        return input
      else
        @view.invalid_marker_selection_message
      end
    end
  end

  def play_game
    until @board.game_is_over? || @board.tie?
      play_round
    end
    evaluate_game_result
  end

  def play_round
    get_player_move({player:@player1,opponent_marker:@player2.marker})
    if @board.game_is_over? || @board.tie?
    else
      get_player_move({player:@player2,opponent_marker:@player1.marker})
    end
  end

  def get_player_move(input_hash)
    player = input_hash[:player]
    opponent_marker = input_hash[:opponent_marker]
    @view.clear_screen
    @view.display_board(@board.spaces)
    if @most_recent_move
      @view.computer_move_message(@most_recent_move)
    end
    if @type == "computer vs computer"
      @view.dot_dot_dot
    end
    if player.type == "human"
      get_human_spot(player)
    else
      computer_spot_choice = player.determine_computer_move({opponent_marker: opponent_marker,board:@board})
      @most_recent_move = ({name:player.name,spot:computer_spot_choice})
      set_computer_spot({spot_number:computer_spot_choice,player_marker:player.marker})
    end

  end

  def set_computer_spot(input_hash)
    @board.mark_space({spot_number:input_hash[:spot_number], player_marker:input_hash[:player_marker]})
  end

  def get_human_spot(player)
    choices = @board.available_spaces
    @view.pick_spot_message({player_name:player.name, choices:choices})
    valid_selection = false
    while valid_selection == false
      selection = gets.chomp
      if choices.include?(selection)
        @board.mark_space({spot_number:selection,player_marker: player.marker})
        valid_selection = true
      else
        @view.pick_spot_message({player_name:player.name, choices:choices})
      end
    end
    @most_recent_move = ({name:player.name,spot:selection})
  end

  def evaluate_game_result
    @view.clear_screen
    if @board.won_game?(@player1.marker)
      @view.won_game(@player1.name)
    elsif @board.won_game?(@player2.marker)
      @view.won_game(@player2.name)
    else
      @view.tie_game
    end
    @view.display_board(@board.spaces)
  end

end

unless $TEST_ENVIRONMENT
  game = Game.new
  game.start_game
end