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
    until game_is_over(@board.spaces) || tie(@board.spaces)
      play_round
    end
    @view.display_board(@board.spaces)
    puts "Game over"
  end

  def play_round
    @view.display_board(@board.spaces)
    get_human_spot(@player1.name)
    if !game_is_over(@board.spaces) && !tie(@board.spaces)
      eval_board
      # computer_spot_choice = @player2.determine_move({opponent_marker: @player1.marker,board:@board})
      # set_computer_spot(computer_spot_choice,@player2.marker)
    end
  end

  def set_computer_spot(marker, spot_choice)
    @board[spot_choice] = marker
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

  def available_choices
    @board.dup.delete_if{|spot| spot == @player1.marker || spot == @player2.marker}
  end

  def eval_board
    spot = nil
    until spot
      if @board.spaces[4] == "4"
        spot = 4
        @board.mark_space({spot_number:4,player_marker:@player2.marker})
      else
        spot = get_best_move(@board, @player2.marker)
        if @board.spaces[spot] != @player1.marker && @board.spaces[spot] != @player2.marker
          @board.mark_space({spot_number:spot,player_marker:@player2.marker})
        else
          spot = nil
        end
      end
    end
  end

  def get_best_move(board, next_player, depth = 0, best_score = {})
    available_spaces = []
    best_move = nil
    @board.spaces.each do |s|
      if s != @player1.marker && s != @player2.marker
        available_spaces << s
      end
    end
    available_spaces.each do |as|
      @board.spaces[as.to_i] = @player2.marker
      if game_is_over(@board.spaces)
        best_move = as.to_i
        @board.spaces[as.to_i] = as
        return best_move
      else
        @board.spaces[as.to_i] = @player1.marker
        if game_is_over(@board.spaces)
          best_move = as.to_i
          @board.spaces[as.to_i] = as
          return best_move
        else
          @board.spaces[as.to_i] = as
        end
      end
    end
    if best_move
      return best_move
    else
      n = rand(0..available_spaces.count)
      return available_spaces[n].to_i
    end
  end

  def game_is_over(board)

    [board[0], board[1], board[2]].uniq.length == 1 ||
    [board[3], board[4], board[5]].uniq.length == 1 ||
    [board[6], board[7], board[8]].uniq.length == 1 ||
    [board[0], board[3], board[6]].uniq.length == 1 ||
    [board[1], board[4], board[7]].uniq.length == 1 ||
    [board[2], board[5], board[8]].uniq.length == 1 ||
    [board[0], board[4], board[8]].uniq.length == 1 ||
    [board[2], board[4], board[6]].uniq.length == 1
  end

  def tie(board)
    board.all? { |spot| spot == @player1.marker || spot == @player2.marker }
  end

end


game = Game.new
game.start_game
