class View

  def self.welcome_message
    puts "Welcome to My Tic-Tac-Toe Game!"
    puts "Have Fun!"
  end

  def self.select_marker_message(name)
    puts "Select a Marker for #{name}"
  end

  def self.get_player_name
    puts "Enter Player Name:"
    name = gets.chomp
    puts "Welcome, #{name}."
    return name
  end

  def self.display_board(board)
      puts "|_#{board[0]}_|_#{board[1]}_|_#{board[2]}_|\n|_#{board[3]}_|_#{board[4]}_|_#{board[5]}_|\n|_#{board[6]}_|_#{board[7]}_|_#{board[8]}_|\n"
  end

  def self.invalid_marker_selection_message
    puts "Marker must be 1 character long and unique. Marker cannot be a number."
    puts "Please make another selection."
  end

  def self.pick_spot_message(name,available_choices)
    puts "#{name}, pick a spot."
    puts "Choose from: #{available_choices.join(',')}"
  end

end