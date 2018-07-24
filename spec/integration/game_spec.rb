require "game"

describe Game do

  before :each do
    @message = Message.new
    @output = StringIO.new
    @board = Board.new(100)
    @validator = CoordinateValidator.new(@board)
  end

  context "one hard coded ship" do
    it "returns win" do
      input = StringIO.new("C\n2\nC\n3")
      console = Console.new(@output, input)
      display = Display.new(console, @message, @validator)
      game = Game.new(display, @board)
      game.play(1, 4)
      expect(@output.string).to include("You win!")
    end
  end

  context "more than one guess" do
    it "returns prompt to keep guessing" do
      input = StringIO.new("A\n1\nB\n1\nC\n2\nC\n3")
      console = Console.new(@output, input)
      board = Board.new(100)
      validator = CoordinateValidator.new(@board)
      display = Display.new(console, @message, @validator)
      game = Game.new(display, @board)
      game.play(1, 4)
      expect(@output.string).to include("You missed, try again")
    end

    it "returns prompt to keep guessing with invalid moves" do
      input = StringIO.new("a\nhello\n2\nworld\nB\n1\nC\n1\nC\n2\nC\n3")
      console = Console.new(@output, input)
      board = Board.new(100)
      validator = CoordinateValidator.new(@board)
      display = Display.new(console, @message, @validator)
      game = Game.new(display, @board)
      game.play(1, 4)
      expect(@output.string).to include("You missed, try again")
    end
  end

  context "computer player guesses coordinates" do
    it "returns complete board" do
      input = StringIO.new
      console = Console.new(@output, input)
      board = Board.new(4)
      validator = CoordinateValidator.new(board)
      display = Display.new(console, @message, validator)
      game = Game.new(display, board)
      board.mark_board("A", 1, "X")
      board.mark_board("A", 2, "X")
      board.mark_board("B", 1, "O")
      game.get_computer_coordinates
      expect(game.row).to eql("B")
      expect(game.column).to eql(2)
    end
  end
end
