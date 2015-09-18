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
    @most_recent_computer_move = nil
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
    @playera.name = @view.get_player_name
    @playerb.name = @view.get_player_name
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
    @player1 = @playera
    @player2 = @playerb

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
    @view.clear_screen
    @view.display_board(@board.spaces)
    if @most_recent_computer_move
      @view.computer_move_message({computer_choice: @most_recent_computer_move,computer_name: @player2.name})
    end
    get_human_spot(@player1.name)
    if !@board.game_is_over? && !@board.tie?
      computer_spot_choice = @player2.determine_computer_move({opponent_marker: @player1.marker,board:@board})
      @most_recent_computer_move = computer_spot_choice
      set_computer_spot({spot_number:computer_spot_choice,player_marker:@player2.marker})
    end
  end

  def set_computer_spot(input_hash)
    @board.mark_space({spot_number:input_hash[:spot_number], player_marker:input_hash[:player_marker]})
  end

  def get_human_spot(name)
    choices = @board.available_spaces
    @view.pick_spot_message({player_name:name, choices:choices})
    valid_selection = false
    while valid_selection == false
      selection = gets.chomp
      if choices.include?(selection)
        @board.mark_space({spot_number:selection,player_marker: @player1.marker})
        valid_selection = true
      else
        @view.pick_spot_message({player_name:name, choices:choices})
      end
    end
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