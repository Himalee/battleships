require "game"

describe Game do
  context "one guess" do
    it "returns win" do
      messages = Messages.new
      output = StringIO.new
      input = StringIO.new("C\n2\nC\n3")
      console = Console.new(output, input)
      display = Display.new(console, messages)
      board = Board.new(100)
      game = Game.new(display, board)
      game.play
      expect(output.string).to include("You win!")
    end

    context "more than one guess" do
      it "returns prompt to keep guessing" do
        messages = Messages.new
        output = StringIO.new
        input = StringIO.new("A\n1\nB\n1\nC\n2\nC\n3")
        console = Console.new(output, input)
        display = Display.new(console, messages)
        board = Board.new(100)
        game = Game.new(display, board)

        game.play
        expect(output.string).to include("You missed, try again")
      end

      it "returns prompt to keep guessing with invalid moves" do
        messages = Messages.new
        output = StringIO.new
        input = StringIO.new("a\nhello\n2\nworld\nB\n1\nC\n1\nC\n2\nC\n3")
        console = Console.new(output, input)
        display = Display.new(console, messages)
        board = Board.new(100)
        game = Game.new(display, board)
        game.play
        expect(output.string).to include("You missed, try again")
      end
    end
  end
end
