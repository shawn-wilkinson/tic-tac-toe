class View

  def self.welcome_message
      puts "
    _______ _        _______           _______
   |__   __(_)      |__   __|         |__   __|
      | |   _  ___     | | __ _  ___     | | ___   ___
      | |  | |/ __|    | |/ _` |/ __|    | |/ _ \\ / _ \\
      | |  | | (__     | | (_| | (__     | | (_) |  __/
      |_|  |_|\\___|    |_|\\__,_|\\___|    |_|\\___/ \\___|
      "
  end

  def self.clear_screen
    print "\e[2J \e[H"
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

  def self.get_computer_name
    puts "Enter the name of your computer opponent:"
    name = gets.chomp
    return name.concat(" (Computer)")
  end

  def self.select_game_type_message
    puts "Please select the type of game you would like to play:"
    puts "1. Human vs Computer"
    puts "2. Human vs Human"
    puts "3. Computer vs Computer"
    puts "Please enter 1,2 or 3 as your choice."
  end

  def self.game_type_message(type)
    puts "Game is set as #{type}!"
  end

  def self.invalid_game_type_message
    puts "Invalid Entry. Please enter '1' '2' or '3'."
  end

   def self.display_board(board)
      puts "|_#{board[0]}_|_#{board[1]}_|_#{board[2]}_|\n|_#{board[3]}_|_#{board[4]}_|_#{board[5]}_|\n|_#{board[6]}_|_#{board[7]}_|_#{board[8]}_|\n"
  end

  def self.invalid_marker_selection_message
    puts "Marker must be 1 character long and unique. Marker cannot be a number."
    puts "Please make another selection."
  end

  def self.pick_spot_message(input_hash)
    puts "#{input_hash[:player_name]}, pick a spot."
    puts "Choose from: #{input_hash[:choices].join(',')}"
  end

  def self.computer_move_message(input_hash)
    puts "#{input_hash[:computer_name]} chose spot #{input_hash[:computer_choice]}"
  end

  def self.tie_game
    puts "It's a tie!"
  end

  def self.won_game(name)
    puts "#{name.upcase} WON!"
  end

end