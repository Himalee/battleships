require "display"
require "messages"

describe Display do
  context "board" do
    it "displays detailed grid" do
      output = StringIO.new
      messages = Messages.new
      console = Console.new(output)
      display = Display.new(console, messages)
      board = {"A"=>[1, 2, 3], "B"=>[1, 2, 3], "C"=>[1, 2, 3]}
      display.present_initial_board(board)
      expect(output.string).to eql("0 1 2 3\nA . . .\nB . . .\nC . . .\n")
    end

    it "displays detailed grid skipping marks (with X)" do
      output = StringIO.new
      messages = Messages.new
      console = Console.new(output)
      display = Display.new(console, messages)
      mark = messages.hit_mark
      board = {"A"=>[1, 2, mark], "B"=>[1, 2, 3], "C"=>[1, 2, 3]}
      display.present_initial_board(board)
      expect(output.string).to eql("0 1 2 3\nA . . X\nB . . .\nC . . .\n")
    end

    it "displays detailed grid skipping marks (with O)" do
      output = StringIO.new
      messages = Messages.new
      console = Console.new(output)
      display = Display.new(console, messages)
      mark = messages.miss_mark
      board = {"A"=>[1, 2, mark], "B"=>[1, 2, 3], "C"=>[1, 2, 3]}
      display.present_initial_board(board)
      expect(output.string).to eql("0 1 2 3\nA . . O\nB . . .\nC . . .\n")
    end
  end
end
