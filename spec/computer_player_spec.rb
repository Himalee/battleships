require "computer_player"
require "board"
require "peg"

describe ComputerPlayer do

  before :each do
    @board = Board.new(4)
    @validator = CoordinateValidator.new(@board)
    @computer_player = ComputerPlayer.new(@board, @validator)
  end

  let(:ship_size) { 2 }
  let(:coordinates) { ["A", 1, 2] }

  context "placing ships randomly on 2x2 grid" do

    it "returns random coordinates given ship size" do
      expect(@computer_player.get_right_direction_coordinates(ship_size)).to eql(["A", 1, 2]).or(eq(["B", 1, 2]))
    end

    it "returns valid coordinates given previously marked grid" do
      @board.mark_board_with_ship(coordinates)
      expect(@computer_player.get_valid_coordinates(ship_size)).to eql(["B", 1, 2])
    end

    it "returns marked grid given valid ship length" do
      @computer_player.place_ship(ship_size)
      expect(@board.grid).to eql({"A"=>["-", "-"], "B"=>[1, 2]}).or(eq({"A"=>[1, 2], "B"=>["-", "-"]}))
    end
  end

  context "places 5 ships on 10x10 grid" do
    it "returns grid with all 5 ships on 10x10 grid" do
      board = Board.new(100)
      validator = CoordinateValidator.new(board)
      computer_player = ComputerPlayer.new(board, validator)
      computer_player.generate_ships
      number_of_ship_marks = board.grid.values.flatten.count(Peg.new.ship)
      expect(number_of_ship_marks).to eql(17)
    end
  end
end
