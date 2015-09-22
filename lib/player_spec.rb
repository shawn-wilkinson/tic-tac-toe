describe "Player" do
  let (:test_player) {Player.new}

  it "can have a name set" do
    test_player.name = "Sara"
    expect(test_player.name).to eq("Sara")
  end

  it "can have a marker set" do
    test_player.marker = "X"
    expect(test_player.marker).to eq("X")
  end

  describe "#initialize" do
    it "is initialized with an empty string as a name" do
      expect(test_player.name).to eq("")
    end
    it "is initialized with an empty string as a marker" do
      expect(test_player.marker).to eq("")
    end
  end

  describe "#set_name" do
    it "calls PlayerView#get_computer_name when player is computer" do
      test_player.type = "computer"
      expect(PlayerView).to receive(:get_computer_name)
      test_player.set_name
    end
    it "calls PlayerView#get_player_name when player is human" do
      test_player.type = "human"
      expect(PlayerView).to receive(:get_player_name)
      test_player.set_name
    end
  end

  describe "#set_marker" do
    it "calls #get_unique_marker" do
      expect(test_player).to receive(:get_unique_marker)
      test_player.set_marker
    end
  end

  describe "#opponent_marker" do
    it "returns correct marker as opponent marker" do
      Player.player_markers=['X','O']
      test_player.marker = 'X'
      expect(test_player.opponent_marker).to eq('O')
    end
  end

  describe "#get_move" do
    it "calls #determine_human_move when player is human" do
      test_player.type = "human"
      board = Board.new
      expect(test_player).to receive(:determine_human_move).with(board)
      test_player.get_move(board)

    end
    it "calls #determine_computer_move when player is computer" do
      test_player.type = "computer"
      board = Board.new
      expect(test_player).to receive(:determine_computer_move).with(board)
      test_player.get_move(board)
    end
  end

  describe "#determine_computer_move" do
    it "will select spots that make it win" do
      test_player.marker = 'X'
      Player.player_markers = ['X','O']
      board = Board.new
      board.spaces = ['X','1','2','3','X','5','6','7','8']
      expect(test_player.determine_computer_move(board)).to eq('8')
    end
    it "will select spots that keep opponent from winning" do
      test_player.marker = 'X'
      Player.player_markers = ['X','O']
      board = Board.new
      board.spaces = ['X','O','X','3','O','5','6','7','8']
      expect(test_player.determine_computer_move(board)).to eq('7')
    end
  end

  describe "#determine_first_move" do
    it "will return 0 if there are 9 remaining spaces (first move of entire game)" do
      board = Board.new
      expect(test_player.determine_first_move(board)).to eq 0
    end
    it "will return 0 if opponent_marker is in center spot" do
      board = Board.new
      Player.player_markers = ['X','O']
      test_player.marker = 'O'
      board.spaces = ['0','1','2','3','X','5','6','7','8']
      expect(test_player.determine_first_move(board)).to eq 0
    end
     it "will return 4 if opponent_marker is not in center spot" do
      board = Board.new
      Player.player_markers = ['X','O']
      test_player.marker = 'O'
      board.spaces = ['0','1','X','3','4','5','6','7','8']
      expect(test_player.determine_first_move(board)).to eq 4
    end
  end

  describe "#determine_second_move" do
    it "will call #response_to_side method when there are 7 spaces left" do
      board = Board.new
      board.spaces = ['0','O','X','3','4','5','6','7','8']
      expect(test_player).to receive(:response_to_side).with(board)
      test_player.determine_second_move(board)
    end
    it "will return 4 if #response_to_side is false and board center is '4'" do
      Player.player_markers = ['X','O']
      test_player.marker = 'O'
      board = Board.new
      board.spaces = ['O','1','X','3','4','5','6','7','8']
      expect(test_player.determine_second_move(board)).to eq 4
    end
    it "will return 8 if #response_to_side is false and board center is taken" do
      Player.player_markers = ['X','O']
      test_player.marker = 'O'
      board = Board.new
      board.spaces = ['O','1','2','3','X','5','6','7','8']
      expect(test_player.determine_second_move(board)).to eq 8
    end
  end

  describe "#determine_third_move" do
    it "will return 4 if board.center is '4'" do
      board = Board.new
      board.spaces = ['O','1','X','3','4','5','X','7','O']
      expect(test_player.determine_third_move(board)).to eq 4
    end
    it "if center is taken, will return a corner" do
      board = Board.new
      board.spaces = ['0','','X','3','O','5','X','7','O']
      expect(test_player.determine_third_move(board)).to eq "0"
    end
    it "if center and all corners are taken, will return a random available space" do
      board = Board.new
      board.spaces = ['O','1','X','X','O','5','X','7','O']
      move = test_player.determine_third_move(board)
      valid_options = ['1','5','7']
      expect(valid_options).to include(move)
    end
  end

  describe "#response_to_side" do
    it "will return false if opponent marker does not occupy a side space" do
      Player.player_markers = ['X','O']
      test_player.marker = 'O'
      board = Board.new
      board.spaces = ['O','1','2','3','X','5','6','7','8']
      expect(test_player.response_to_side(board)).to be false
    end
    it "will return 2 if opponent marker is not in spot 1" do
      Player.player_markers = ['X','O']
      test_player.marker = 'O'
      board = Board.new
      board.spaces = ['O','1','2','3','4','5','6','X','8']
      expect(test_player.response_to_side(board)).to eq 2
    end
    it "will return 6 if opponent marker is in spot 1" do
      Player.player_markers = ['X','O']
      test_player.marker = 'O'
      board = Board.new
      board.spaces = ['O','X','2','3','4','5','6','7','8']
      expect(test_player.response_to_side(board)).to eq 6
    end
  end

  describe "#response_to_opposite_corners" do
    it "will return 1 if opponent_marker is in two opposite corners" do
      Player.player_markers = ['X','O']
      test_player.marker = 'O'
      board = Board.new
      board.spaces = ['O','1','X','3','4','5','X','7','8']
      expect(test_player.response_to_opposite_corners(board)).to eq 1
    end
    it "will return false if opponent_marker is not in two opposite corners" do
      Player.player_markers = ['X','O']
      test_player.marker = 'O'
      board = Board.new
      board.spaces = ['O','X','2','3','4','5','X','7','8']
      expect(test_player.response_to_opposite_corners(board)).to be false
    end
  end

  describe "#response_to_corner_and_opposite_side" do
    it "returns 8 when opponent marker is in spot 0 and either spot 5 or 7" do
      Player.player_markers = ['X','O']
      test_player.marker = 'O'
      board = Board.new
      board.spaces = ['X','1','2','3','4','X','O','7','8']
      expect(test_player.response_to_corner_and_opposite_side(board)).to eq 8
    end
    it "returns 6 when opponent marker is in spot 2 and either spot 3 or 7" do
      Player.player_markers = ['X','O']
      test_player.marker = 'O'
      board = Board.new
      board.spaces = ['0','1','X','X','O','5','6','7','8']
      expect(test_player.response_to_corner_and_opposite_side(board)).to eq 6
    end
    it "returns 2 when opponent marker is in spot 6 and either spot 1 or 5" do
      Player.player_markers = ['X','O']
      test_player.marker = 'O'
      board = Board.new
      board.spaces = ['0','X','2','O','4','5','X','7','8']
      expect(test_player.response_to_corner_and_opposite_side(board)).to eq 2
    end
    it "returns 0 when opponent marker is in spot 8 and either spot 1 or 3" do
      Player.player_markers = ['X','O']
      test_player.marker = 'O'
      board = Board.new
      board.spaces = ['0','1','2','X','4','O','6','7','X']
      expect(test_player.response_to_corner_and_opposite_side(board)).to eq 0
    end
  end

  describe "#block_or_win" do
    it "will first identify space that would allow player to win" do
      test_player.marker = 'X'
      board = Board.new
      board.spaces = ['X','X','2','3','4','5','O','O','8']
      move = test_player.block_or_win(board)
      expect(move).to eq('2')
    end
    it "will identify space that would allow oppoent to win, if no option for player to win themselves" do
      test_player.marker = 'X'
      Player.player_markers = ['X','O']
      board = Board.new
      board.spaces = ['0','X','2','3','4','5','O','O','8']
      move = test_player.block_or_win(board)
      expect(move).to eq('8')
    end
    it "will return false if there are no game-winning or saving moves available" do
      test_player.marker = 'X'
      board = Board.new
      board.spaces = ['0','X','2','3','4','5','6','O','8']
      move = test_player.block_or_win(board)
      expect(move).to be false
    end
  end
end