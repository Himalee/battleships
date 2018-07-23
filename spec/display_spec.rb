require "display"
require "messages"
require "peg"

describe Display do
  context "board" do
    it "displays detailed grid" do
      output = StringIO.new
      messages = Messages.new
      console = Console.new(output)
      display = Display.new(console, messages)
      board = {"A"=>[1, 2, 3], "B"=>[1, 2, 3], "C"=>[1, 2, 3]}
      display.present_board(board)
      expect(output.string).to eql("0 1 2 3\nA . . .\nB . . .\nC . . .\n")
    end

    it "displays detailed with hit mark" do
      output = StringIO.new
      messages = Messages.new
      console = Console.new(output)
      display = Display.new(console, messages)
      mark = Peg.new.hit
      board = {"A"=>[1, 2, mark], "B"=>[1, 2, 3], "C"=>[1, 2, 3]}
      display.present_board(board)
      expect(output.string).to eql("0 1 2 3\nA . . #{mark}\nB . . .\nC . . .\n")
    end

    it "displays detailed grid with miss mark" do
      output = StringIO.new
      messages = Messages.new
      console = Console.new(output)
      display = Display.new(console, messages)
      mark = Peg.new.miss
      board = {"A"=>[1, 2, mark], "B"=>[1, 2, 3], "C"=>[1, 2, 3]}
      display.present_board(board)
      expect(output.string).to eql("0 1 2 3\nA . . #{mark}\nB . . .\nC . . .\n")
    end
  end

  context "validates user input" do
    it "returns row 'A', given 'a'" do
      output = StringIO.new
      input = StringIO.new("a")
      messages = Messages.new
      console = Console.new(output, input)
      display = Display.new(console, messages)
      expect(display.valid_row(10)).to eql("A")
    end

    it "returns row, given invalid moves" do
      output = StringIO.new
      input = StringIO.new("1\n4\nhello\nAB\nc")
      messages = Messages.new
      console = Console.new(output, input)
      display = Display.new(console, messages)
      expect(display.valid_row(10)).to eql("C")
    end

    it "returns column '1', given '1'" do
      output = StringIO.new
      input = StringIO.new("1")
      messages = Messages.new
      console = Console.new(output, input)
      display = Display.new(console, messages)
      expect(display.valid_column(10)).to eql("1")
    end

    it "returns column, given invalid moves" do
      output = StringIO.new
      input = StringIO.new("hello\nD\n123\n12\n11\n10")
      messages = Messages.new
      console = Console.new(output, input)
      display = Display.new(console, messages)
      expect(display.valid_column(10)).to eql("10")
    end
  end
end
