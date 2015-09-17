require_relative "player.rb"
require_relative "view.rb"
require_relative "board.rb"


class Game
  def initialize
    @board = Board.new
    @player1 = Player.new
    @player2 = Player.new
    @view = View
    @most_recent_computer_move = nil
  end

  def start_game
    @view.welcome_message
    set_up_game
    play_game
  end

  def set_up_game
    enter_player_names
    select_markers
  end

  def enter_player_names
    @player1.name = @view.get_player_name
    @player2.name = @view.get_computer_name
  end

  def select_markers
    @player1.marker = get_unique_marker(@player1.name)
    @player2.marker = get_unique_marker(@player2.name)
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