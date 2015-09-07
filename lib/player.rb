class Player
  attr_accessor :marker, :name

  def initialize
    @marker = ""
    @name = ""
  end

  def determine_move(input_hash)
    opponent_marker = input_hash[:opponent_marker]
    board = input_hash[:board]
    if board[4] == "4"
      return 4
    else
      return spot
    end
  end

end