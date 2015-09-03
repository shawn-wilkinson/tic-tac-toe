require_relative "player.rb"
require_relative "view.rb"

class Game
  def initialize
    @board = ["0", "1", "2", "3", "4", "5", "6", "7", "8"]
    @player1 = Player.new
    @player1.name = "Player 1"
    @player2 = Player.new
    @player2.name = "Player 2"
    @view = View

  end

  def start_game
    @view.welcome_message
    set_up_game
    @view.display_board(@board)
    puts "Please select your spot."
    until game_is_over(@board) || tie(@board)
      get_human_spot
      if !game_is_over(@board) && !tie(@board)
        eval_board
      end
      @view.display_board(@board)
    end
    puts "Game over"
  end

  def set_up_game
    determine_players
    select_markers
  end

  def determine_players
    #allow player to determine human / computer opponent
  end

  def select_markers
    @view.select_marker_message(@player1.name)
    @player1.marker = get_unique_marker
    @view.select_marker_message(@player2.name)
    @player2.marker = get_unique_marker
  end

  def get_unique_marker
    #find way to keep users from selecting a NUMBER as their marker
    while true
      input = gets.chomp
      if (input.length == 1) && (input != @player1.marker) && (input != @player2.marker)
        return input
      else
        @view.invalid_marker_selection_message
      end
    end
  end

  def get_human_spot
    spot = nil
    until spot
      spot = gets.chomp.to_i
      if @board[spot] != @player1.marker && @board[spot] != @player2.marker
        @board[spot] = @player1.marker
      else
        spot = nil
      end
    end
  end

  def eval_board
    spot = nil
    until spot
      if @board[4] == "4"
        spot = 4
        @board[spot] = @player2.marker
      else
        spot = get_best_move(@board, @player2.marker)
        if @board[spot] != @player1.marker && @board[spot] != @player2.marker
          @board[spot] = @player2.marker
        else
          spot = nil
        end
      end
    end
  end

  def get_best_move(board, next_player, depth = 0, best_score = {})
    available_spaces = []
    best_move = nil
    board.each do |s|
      if s != @player1.marker && s != @player2.marker
        available_spaces << s
      end
    end
    available_spaces.each do |as|
      board[as.to_i] = @player2.marker
      if game_is_over(board)
        best_move = as.to_i
        board[as.to_i] = as
        return best_move
      else
        board[as.to_i] = @player1.marker
        if game_is_over(board)
          best_move = as.to_i
          board[as.to_i] = as
          return best_move
        else
          board[as.to_i] = as
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
