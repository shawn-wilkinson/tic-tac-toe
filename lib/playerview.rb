class PlayerView

  def self.pick_spot_message(player_name,choices)
    puts "#{player_name}, pick a spot."
    puts "Choose from: #{choices.join(',')}"
  end


end