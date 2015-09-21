class GameView

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
    puts "Invalid Entry. Please enter '1', '2' or '3'."
  end

  def self.who_plays_first_message(name1,name2)
    puts "Who should play first?"
    puts "1. #{name1}"
    puts "2. #{name2}"
    puts "Please enter 1 or 2 as your choice"
  end

  def self.invalid_first_player_message
    puts "Invalid Entry. Please enter '1' or '2'."
  end

  def self.display_board(board)
    puts "|_#{board[0]}_|_#{board[1]}_|_#{board[2]}_|\n|_#{board[3]}_|_#{board[4]}_|_#{board[5]}_|\n|_#{board[6]}_|_#{board[7]}_|_#{board[8]}_|\n"
  end

  def self.recent_move_message(input_hash)
    puts "#{input_hash[:name]} chose spot #{input_hash[:spot]}"
  end

  def self.dot_dot_dot
    7.times do
      print "."
      sleep(0.5)
    end
  end

  def self.tie_game
    puts "It's a tie!"
  end

  def self.won_game(name)
    puts "#{name.upcase} WON!"
  end

end