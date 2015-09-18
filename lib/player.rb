class Player
  attr_accessor :marker, :name, :type

  def initialize
    @marker = ""
    @name = ""
    @type = nil
  end

  def determine_computer_move(input_hash)
    opponent_marker = input_hash[:opponent_marker]
    board = input_hash[:board]
    if board.spaces_left > 7
      return determine_first_move({board:board, opponent_marker: opponent_marker})
    elsif identify_crucial_space({board:board, opponent_marker: opponent_marker})
      return identify_crucial_space({board:board, opponent_marker: opponent_marker})
    elsif board.spaces_left > 5
      return determine_second_move({board:board, opponent_marker: opponent_marker})
    else
      return select_space(board)
    end
  end

  def determine_first_move(input_hash)
    board = input_hash[:board]
    spaces = board.spaces
    opponent_marker = input_hash[:opponent_marker]
    if board.spaces_left == 9 || board.center == opponent_marker
      return 0
    else
      return 4
    end
  end

  def determine_second_move(input_hash)
    board = input_hash[:board]
    spaces = board.spaces
    opponent_marker = input_hash[:opponent_marker]
    if board.spaces_left == 7
      if spaces[8] == '8'
        return 8
      else
        return 4
      end
    else
      if (spaces[0] == opponent_marker && spaces[8] == opponent_marker) || (spaces[2] == opponent_marker && spaces[6] == opponent_marker)
        return 1
      elsif spaces[4] == '4'
        return 4
      else
        return board.return_random_corner
      end
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
    if board.return_random_corner
      return board.return_random_corner
    else
      return  board.available_spaces.sample
    end
  end

end