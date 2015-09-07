class Board

  attr_accessor :spaces

def initialize
  @spaces = ["0", "1", "2", "3", "4", "5", "6", "7", "8"]
  @orig_spaces = @spaces.dup
end

def available_spaces
  @spaces.dup.delete_if{|spot| !@orig_spaces.include?(spot)}
end

def mark_space(input_hash)
  @spaces[input_hash[:spot_number].to_i] = input_hash[:player_marker]
end

end


