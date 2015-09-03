class View

  def self.welcome_message
    puts "Welcome to My Tic-Tac-Toe Game!"
    puts "Have Fun!"
  end

  def self.select_marker_message(name)
    puts "Select a Marker for #{name}"
  end

  def self.display_board(board)
      puts "|_#{board[0]}_|_#{board[1]}_|_#{board[2]}_|\n|_#{board[3]}_|_#{board[4]}_|_#{board[5]}_|\n|_#{board[6]}_|_#{board[7]}_|_#{board[8]}_|\n"
  end

  def self.invalid_marker_selection_message
    puts "Please make another selection. Marker must be 1 character long and unique."
  end

end