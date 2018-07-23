require "computer_player"
require "board"
require "peg"

describe ComputerPlayer do

  before :each do
    @board = Board.new(4)
    @computer_player = ComputerPlayer.new(@board)
  end

  let(:coordinates) { ["A", 1, 2] }
  let(:ship_size) { 2 }

  context "placing ships randomly on 2x2 grid" do

    it "returns random coordinates given ship size" do
      expect(@computer_player.get_right_direction_coordinates(ship_size)).to eql(["A", 1, 2]).or(eq(["B", 1, 2]))
    end

    it "marks board with a ship given coordinates" do
      expect(@computer_player.mark_board_with_ship(coordinates)).to eql({"A"=>["-", "-"], "B"=>[1, 2]})
    end

    it "returns true given valid coordinates" do
      expect(@computer_player.coordinates_do_not_include_ship?(coordinates)).to be true
    end

    it "returns false given invalid coordinates test" do
      @computer_player.mark_board_with_ship(coordinates)
      expect(@computer_player.coordinates_do_not_include_ship?(coordinates)).to be false
    end

    it "returns valid coordinates given previously marked grid" do
      @computer_player.mark_board_with_ship(coordinates)
      expect(@computer_player.get_valid_coordinates(ship_size)).to eql(["B", 1, 2])
    end

    it "returns marked grid given valid ship length" do
      @computer_player.randomly_place_ship(ship_size)
      expect(@board.grid).to eql({"A"=>["-", "-"], "B"=>[1, 2]}).or(eq({"A"=>[1, 2], "B"=>["-", "-"]}))
    end

    it "returns unmarked gird given invalid ship length" do
      invalid_ship_length = 3
      @computer_player.randomly_place_ship(invalid_ship_length)
      expect(@board.grid).to eql({"A"=>[1, 2], "B"=>[1, 2]})
    end
  end

  context "places 5 ships on 10x10 grid" do
    it "returns grid with all 5 ships on 10x10 grid" do
      board = Board.new(100)
      computer_player = ComputerPlayer.new(board)
      computer_player.generate_ships
      number_of_ship_marks = board.grid.values.flatten.count(Peg.new.ship)
      expect(number_of_ship_marks).to eql(17)
    end
  end
end
