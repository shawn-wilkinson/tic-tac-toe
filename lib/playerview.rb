class PlayerView

  def self.pick_spot_message(player_name,choices)
    puts "#{player_name}, pick a spot."
    puts "Choose from: #{choices.join(',')}"
  end

  def self.get_player_name
    puts "Enter Player Name:"
    name = gets.chomp
    puts "Welcome, #{name}."
    return name
  end

  def self.get_computer_name
    puts "Enter Computer Player Name:"
    name = gets.chomp
    return name.concat(" (Computer)")
  end

  def self.select_marker_message(name)
    puts "Select a Marker for #{name}"
  end

  def self.invalid_marker_selection_message
    puts "Marker must be 1 character long and unique. Marker cannot be a number."
    puts "Please make another selection."
  end


end