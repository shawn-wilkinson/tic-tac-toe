describe "Board" do
  let (:test_board) {Board.new}

  describe "#initialize" do
    it "creates a board with an array of 9 spaces" do
      expect(test_board.spaces.length).to eq 9
    end
    it "creates a board with spaces equal to an array of strings numbered '0' - '9'" do
      expect(test_board.spaces).to eq(['0','1','2','3','4','5','6','7','8'])
    end
  end

  describe "#available_spaces" do
    it "shows all spaces as available when no moves have been made" do
      expect(test_board.available_spaces).to eq(['0','1','2','3','4','5','6','7','8'])
    end
    it "will show only available spaces after moves have been taken" do
      test_board.spaces = ['0','X','2','3','O','5','6','X','8']
      expect(test_board.available_spaces).to eq(['0','2','3','5','6','8'])
    end
  end

  describe "#spaces_left" do
    it "returns the number of available spaces" do
      test_board.spaces = ['0','X','2','3','O','5','6','X','8']
      expect(test_board.spaces_left).to eq(6)
    end
  end

  describe "#center" do
    it "will return '4' when center is empty" do
      test_board.spaces = ['0','X','2','3','4','5','6','X','8']
      expect(test_board.center).to eq('4')
    end
    it "will return player piece if occupied" do
      test_board.spaces = ['0','X','2','3','O','5','6','X','8']
      expect(test_board.center).to eq('O')
    end
  end

  describe "#corners" do
    it "returns the contents of the board's corners" do
      test_board.spaces = ['0','X','2','3','O','5','6','X','8']
      expect(test_board.corners).to eq(['0','2','6','8'])
    end
  end

  describe "#sides" do
    it "returns the contents of the board's sides" do
      test_board.spaces = ['0','X','2','3','O','5','6','X','8']
      expect(test_board.sides).to eq(['X','3','5','X'])
    end
  end

  describe "#return_random_corner" do
    it "returns corner only available corner, if only one is left" do
      test_board.spaces = ['0','X','O','3','O','5','X','7','O']
      expect(test_board.return_random_corner).to eq('0')
    end

    it "returns a corner that is not occupied by a player marker" do
      test_board.spaces = ['0','X','3','3','O','5','X','7','O']
      selection = test_board.return_random_corner
      valid_options = ['0','3']
      expect(valid_options).to include(selection)
    end
  end

  describe "#return_random_space" do
    it "returns a space that is not occupied by a player marker" do
      test_board.spaces = ['0','X','O','3','O','5','X','7','O']
      selection = test_board.return_random_space
      valid_options = ['0','3','5','7']
      expect(valid_options).to include(selection)
    end
  end

  describe "#mark_space" do
    it "can mark a specific spot with a given marker" do
      test_board.mark_space({spot_number:'4',player_marker:'X'})
      expect(test_board.spaces[4]).to eq('X')
    end
  end

  describe "#game_is_over?" do
    it "returns false when game is not over" do
      test_board.spaces = ['X','1','O','3','4','X','6','7','O']
      expect(test_board.game_is_over?).to be false
    end
    it "returns true when game is over" do
      test_board.spaces = ['X','1','O','X','4','O','X','7','O']
      expect(test_board.game_is_over?).to be true
    end
  end

  describe "#tie?" do
    it "returns false if not all spots are filled" do
      test_board.spaces = ['X','1','O','3','4','X','6','7','O']
      expect(test_board.tie?).to be false
    end
    it "returns true if all spots are filled" do
      test_board.spaces = ['X','O','X','O','O','X','X','X','O']
      expect(test_board.tie?).to be true
    end
  end
end





# describe "Player" do
#   let (:test_player) {Player.new}

#   it "can have a name set" do
#     test_player.name = "Sara"
#     expect(test_player.name).to eq("Sara")
#   end

#   it "can have a marker set" do
#     test_player.marker = "X"
#     expect(test_player.marker).to eq("X")
#   end

#   describe "#initialize" do
#     it "is initialized with an empty string as a name" do
#       expect(test_player.name).to eq("")
#     end
#     it "is initialized with an empty string as a marker" do
#       expect(test_player.marker).to eq("")
#     end
#   end

#   describe "#determine_computer_move" do
#     it "will select spots that make it win" do
#       test_player.marker = 'X'
#       Player.player_markers = ['X','O']
#       board = Board.new
#       board.spaces = ['X','1','2','3','X','5','6','7','8']
#       expect(test_player.determine_computer_move(board)).to eq('8')

#     end
#     it "will select spots that keep opponent from winning" do
#       test_player.marker = 'X'
#       Player.player_markers = ['X','O']
#       board = Board.new
#       board.spaces = ['X','O','X','3','O','5','6','7','8']
#       expect(test_player.determine_computer_move(board)).to eq('7')
#     end
#   end

#   describe "#block_or_win" do
#     it "will first identify space that would allow player to win" do
#       test_player.marker = 'X'
#       board = Board.new
#       board.spaces = ['X','X','2','3','4','5','O','O','8']
#       move = test_player.block_or_win(board)
#       expect(move).to eq('2')
#     end
#     it "will identify space that would allow oppoent to win, if no option for player to win themselves" do
#       test_player.marker = 'X'
#       Player.player_markers = ['X','O']
#       board = Board.new
#       board.spaces = ['0','X','2','3','4','5','O','O','8']
#       move = test_player.block_or_win(board)
#       expect(move).to eq('8')
#     end
#     it "will return false if there are no game-winning or saving moves available" do
#       test_player.marker = 'X'
#       board = Board.new
#       board.spaces = ['0','X','2','3','4','5','6','O','8']
#       move = test_player.block_or_win(board)
#       expect(move).to be false
#     end
#   end


# end