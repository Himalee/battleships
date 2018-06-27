require "display"

describe Display do
  context "board" do
    it "displays detailed grid" do
      output = StringIO.new
      console = Console.new(output)
      display = Display.new(console)
      board = {"A"=>[1, 2, 3], "B"=>[1, 2, 3], "C"=>[1, 2, 3]}
      display.present_board(board)
      expect(output.string).to eql("0 1 2 3\nA . . .\nB . . .\nC . . .\n")
    end
  end
end
