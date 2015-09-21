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