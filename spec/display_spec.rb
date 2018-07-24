require "display"
require "message"
require "peg"
require "coordinate_validator"
require "board"

describe Display do

  before :each do
    @output = StringIO.new
    @message = Message.new
    console = Console.new(@output)
    @board = Board.new(9)
    @validator = CoordinateValidator.new(@board)
    @display = Display.new(console, @message, @validator)
  end

  context "board" do
    it "displays detailed grid" do
      board = {"A"=>[1, 2, 3], "B"=>[1, 2, 3], "C"=>[1, 2, 3]}
      @display.present_board(board)
      expect(@output.string).to eql("0 1 2 3\nA . . .\nB . . .\nC . . .\n")
    end

    it "displays detailed with hit mark" do
      mark = Peg::HIT
      board = {"A"=>[1, 2, mark], "B"=>[1, 2, 3], "C"=>[1, 2, 3]}
      @display.present_board(board)
      expect(@output.string).to eql("0 1 2 3\nA . . #{mark}\nB . . .\nC . . .\n")
    end

    it "displays detailed grid with miss mark" do
      mark = Peg::MISS
      board = {"A"=>[1, 2, mark], "B"=>[1, 2, 3], "C"=>[1, 2, 3]}
      @display.present_board(board)
      expect(@output.string).to eql("0 1 2 3\nA . . #{mark}\nB . . .\nC . . .\n")
    end
  end

  context "validates user input" do
    it "returns row 'A', given 'a'" do
      input = StringIO.new("a")
      console = Console.new(@output, input)
      display = Display.new(console, @message, @validator)
      expect(display.valid_row(10)).to eql("A")
    end

    it "returns row, given invalid moves" do
      input = StringIO.new("1\n4\nhello\nAB\nc")
      console = Console.new(@output, input)
      display = Display.new(console, @message, @validator)
      expect(display.valid_row(10)).to eql("C")
    end

    it "returns column '1', given '1'" do
      input = StringIO.new("1")
      console = Console.new(@output, input)
      display = Display.new(console, @message, @validator)
      expect(display.valid_column(10)).to eql("1")
    end

    it "returns column, given invalid moves" do
      input = StringIO.new("hello\nD\n123\n12\n11\n10")
      console = Console.new(@output, input)
      display = Display.new(console, @message, @validator)
      expect(display.valid_column(10)).to eql("10")
    end
  end

  context "validates user input for placing ships" do
    it "returns row" do
      input = StringIO.new("1\nd\na")
      console = Console.new(@output, input)
      display = Display.new(console, @message, @validator)
      expect(display.get_valid_ship_row(4)).to eql("A")
    end

    it "returns column" do
      input = StringIO.new("a\n4\n2")
      console = Console.new(@output, input)
      display = Display.new(console, @message, @validator)
      expect(display.get_valid_ship_column(2)).to eql(2)
    end

    it "returns array of coordinates given 2x2 grid" do
      input = StringIO.new("1\nd\na\na\n4\n1")
      console = Console.new(@output, input)
      board = Board.new(4)
      display = Display.new(console, @message, @validator)
      expect(display.get_valid_coordinates(2, board)).to eql(["A", 1, 2])
    end

    it "returns array of coordinates given 3x3 grid" do
      input = StringIO.new("a\n1")
      console = Console.new(@output, input)
      board = Board.new(9)
      display = Display.new(console, @message, @validator)
      expect(display.get_valid_coordinates(3, board)).to eql(["A", 1, 2, 3])
    end

    it "returns array of coordinates given invalid coordinates" do
      @board.mark_board_with_ship(["A", 1, 2])
      input = StringIO.new("a\n1\nb\n1")
      console = Console.new(@output, input)
      display = Display.new(console, @message, @validator)
      expect(display.get_valid_coordinates(2, @board)).to eql(["B", 1, 2])
    end
  end
end
