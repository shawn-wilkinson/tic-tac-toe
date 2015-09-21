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
      return determine_first_move(board,opponent_marker)
    elsif block_or_win(board,opponent_marker)
      return block_or_win(board,opponent_marker)
    elsif board.spaces_left > 5
      return determine_second_move(board,opponent_marker)
    elsif board.spaces_left > 3
      return determine_third_move(board,opponent_marker)
    else
      return board.select_random_space
    end
  end

  def determine_first_move(board,opponent_marker)
    spaces = board.spaces
    if board.spaces_left == 9
      return 0
    else
      return 0 if board.center == opponent_marker
      return 4
    end
  end

  def determine_second_move(board,opponent_marker)
    spaces = board.spaces
    if board.spaces_left == 7
      if response_to_side(board,opponent_marker)
        return response_to_side(board,opponent_marker)
      end
      return 4 if board.center == '4'
      return 8
    else
      if response_to_opposite_corners(board,opponent_marker)
        return response_to_opposite_corners(board,opponent_marker)
      elsif response_to_corner_and_opposite_side(board,opponent_marker)
        return response_to_corner_and_opposite_side(board,opponent_marker)
      elsif board.center == '4'
        return 4
      else
        return board.return_random_corner
      end
    end
  end

  def determine_third_move(board,opponent_marker)
    return 4 if board.center == '4'
    return board.select_random_corner if board.select_random_corner
    return board.select_random_space
  end

  def response_to_side(board,opponent_marker)
    if board.sides.include?(opponent_marker) && board.sides.include?('1')
      return 2
    elsif board.sides.include?(opponent_marker)
      return 6
    else
      return false
    end
  end

  def response_to_opposite_corners(board,opponent_marker)
    spaces = board.spaces
    if (spaces[0] == opponent_marker && spaces[8] == opponent_marker) || (spaces[2] == opponent_marker && spaces[6] == opponent_marker)
      return 1
    else
      return false
    end
  end

  def response_to_corner_and_opposite_side(board,opponent_marker)
    spaces = board.spaces
    result = false
    if board.corners.grep(opponent_marker).count == 1 && board.sides.grep(opponent_marker).count == 1
        if spaces[0] == opponent_marker
          if spaces[5] == opponent_marker || spaces[7] == opponent_marker
            result = 8
          end
        elsif spaces[2] == opponent_marker
          if spaces[3] == opponent_marker || spaces[7] == opponent_marker
            result = 6
          end
        elsif spaces[6] == opponent_marker
          if spaces[1] == opponent_marker || spaces[5] == opponent_marker
            result = 2
          end
        else
          if spaces[1] == opponent_marker || spaces[3] == opponent_marker
            result = 0
          end
        end
      end
      return result
  end

  def block_or_win(board,opponent_marker)
    result = false
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

end