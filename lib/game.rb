require_relative "player.rb"
require_relative "view.rb"
require_relative "board.rb"

class Game
  def initialize
    @board = Board.new
    @player1 = Player.new
    @player2 = Player.new
    @view = View
  end

  def start_game
    @view.welcome_message
    set_up_game
    play_game
  end

  def set_up_game
    determine_player_types
    enter_player_names
    select_markers
  end

  def determine_player_types
    #allow player to determine human / computer opponent
  end

  def enter_player_names
    @player1.name = @view.get_player_name
    @player2.name = @view.get_player_name
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
    @view.display_board(@board.spaces)
    puts "Game over"
  end

  def play_round
    @view.display_board(@board.spaces)
    get_human_spot(@player1.name)
    if !@board.game_is_over? && !@board.tie?
      # eval_board
      computer_spot_choice = @player2.determine_computer_move({opponent_marker: @player1.marker,board:@board})
      set_computer_spot(computer_spot_choice,@player2.marker)
    end
  end

  def set_computer_spot(spot_choice, marker)
    @board.mark_space({spot_number:spot_choice,player_marker:marker})
  end

  def get_human_spot(name)
    choices = @board.available_spaces
    @view.pick_spot_message(name,choices)
    valid_selection = false
    while valid_selection == false
      selection = gets.chomp
      if choices.include?(selection)
        @board.mark_space({spot_number:selection,player_marker: @player1.marker})
        valid_selection = true
      else
        @view.pick_spot_message(name,choices)
      end
    end
  end

end


game = Game.new
game.start_game
