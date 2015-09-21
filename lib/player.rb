require_relative "playerview.rb"

class Player
  attr_accessor :marker, :name, :type, :player_markers

  @@player_markers = []

  def initialize
    @marker = ""
    @name = ""
    @type = nil
    @view = PlayerView
  end

  def set_marker(marker)
    @marker = marker
    @@player_markers << marker
  end

  def opponent_marker
    @@player_markers.select{|element| element != @marker}[0]
  end

  def get_move(board)
    if @type == 'human'
      return determine_human_move(board)
    else
      return determine_computer_move(board)
    end
  end

  def determine_human_move(board)
    choices = board.available_spaces
    @view.pick_spot_message(@name,choices)
    valid_selection = false
    while valid_selection == false
      selection = gets.chomp
      if choices.include?(selection)
        valid_selection = true
      else
        @view.pick_spot_message(@name,choices)
      end
    end
    return selection
  end


  def determine_computer_move(board)
    if board.spaces_left > 7
      return determine_first_move(board)
    elsif block_or_win(board)
      return block_or_win(board)
    elsif board.spaces_left > 5
      return determine_second_move(board)
    elsif board.spaces_left > 3
      return determine_third_move(board)
    else
      return board.return_random_space
    end
  end

  def determine_first_move(board)
    spaces = board.spaces
    if board.spaces_left == 9
      return 0
    else
      return 0 if board.center == opponent_marker
      return 4
    end
  end

  def determine_second_move(board)
    spaces = board.spaces
    if board.spaces_left == 7
      if response_to_side(board)
        return response_to_side(board)
      end
      return 4 if board.center == '4'
      return 8
    else
      if response_to_opposite_corners(board)
        return response_to_opposite_corners(board)
      elsif response_to_corner_and_opposite_side(board)
        return response_to_corner_and_opposite_side(board)
      elsif board.center == '4'
        return 4
      else
        return board.return_random_corner
      end
    end
  end

  def determine_third_move(board)
    return 4 if board.center == '4'
    return board.return_random_corner if board.return_random_corner
    return board.return_random_space
  end

  def response_to_side(board)
    if board.sides.include?(opponent_marker) && board.sides.include?('1')
      return 2
    elsif board.sides.include?(opponent_marker)
      return 6
    else
      return false
    end
  end

  def response_to_opposite_corners(board)
    spaces = board.spaces
    if (spaces[0] == opponent_marker && spaces[8] == opponent_marker) || (spaces[2] == opponent_marker && spaces[6] == opponent_marker)
      return 1
    else
      return false
    end
  end

  def response_to_corner_and_opposite_side(board)
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

  def block_or_win(board)
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