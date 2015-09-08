class Player
  attr_accessor :marker, :name

  def initialize
    @marker = ""
    @name = ""
  end

  def determine_computer_move(input_hash)
    opponent_marker = input_hash[:opponent_marker]
    board = input_hash[:board]
    if board.available_spaces.include? ("4")
      return 4
    elsif identify_crucial_space({board:board, opponent_marker: opponent_marker})
      return identify_crucial_space({board:board, opponent_marker: opponent_marker})
    else
      return select_space(board)
    end
  end

  def identify_crucial_space(input_hash)
    result = false
    board = input_hash[:board]
    opponent_marker = input_hash[:opponent_marker]
    #first, determine if any move could win current player the game
    board.available_spaces.each do |space|
      if board.winning_move?({spot_number:space,player_marker:@marker})
        result = space
      end
    end
    #now, determine if any move could keep opponent from winning
    if !result
      board.available_spaces.each do |space|
        if board.winning_move?({spot_number:space,player_marker:opponent_marker})
          result = space
        end
      end
    end
    return result
  end

  def select_space(board)
    board.return_random_corner
  end

end