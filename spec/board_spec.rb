require "board"
require "peg"

describe Board do

  before :each do
    @board = Board.new(9)
  end

  let(:coordinates) { ["A", 1, 2, 3] }

  it "returns hash of 9x9 grid" do
    expect(@board.create_grid).to eql({"A"=>[1, 2, 3], "B"=>[1, 2, 3], "C"=>[1, 2, 3]})
  end

  it "returns hash of 2x2 grid" do
    board = Board.new(4)
    expect(board.create_grid).to eql({"A"=>[1, 2], "B"=>[1, 2]})
  end

  context "returns new hash" do
    it "given coordinate A1" do
      expect(@board.mark_board("A", 1, "-")).to eql({"A"=>["-", 2, 3], "B"=>[1, 2, 3], "C"=>[1, 2, 3]})
    end

    it "given coordinate C2" do
      expect(@board.mark_board("C", 2, "-")).to eql({"A"=>[1, 2, 3], "B"=>[1, 2, 3], "C"=>[1, "-", 3]})
    end

    it "given 2 coordinates C2 & C3 placing ship on board" do
      expect(@board.grid_with_one_hardcoded_ship).to eql({"A"=>["-", "-", 3], "B"=>[1, 2, 3], "C"=>[1, 2, 3]})
    end

    it "marks board with a ship given ship coordinates" do
      expect(@board.mark_board_with_ship(coordinates)).to eql({"A"=>["-", "-", "-"], "B"=>[1, 2, 3], "C"=>[1, 2, 3]})
    end
  end

  context "grid with one ship" do
    it "given missed coordinate, returns false" do
      expect(@board.includes_mark?("A", 1, Peg::SHIP)).to be false
      expect(@board.includes_mark?("C", 1, Peg::SHIP)).to be false
    end

    it "given a hit coordinate, returns true" do
      @board.grid_with_one_hardcoded_ship
      expect(@board.includes_mark?("A", 1, Peg::SHIP)).to be true
      expect(@board.includes_mark?("A", 2, Peg::SHIP)).to be true
    end

    it "given all hit coordinates, returns true" do
      @board.grid_with_one_hardcoded_ship
      @board.mark_board("A", 1, "X")
      @board.mark_board("A", 2, "X")
      expect(@board.hit_all?(@board.grid)).to be true
    end

    it "not given all hit coordinates, returns false" do
      @board.grid_with_one_hardcoded_ship
      @board.mark_board("B", 2, "X")
      expect(@board.hit_all?(@board.grid)).to be false
    end
  end

  context "coordinate can only be chosen once" do
    it "returns false given coordinate with no mark" do
      expect(@board.includes_mark?("A", 1, Peg::HIT)).to be false
    end

    it "returns true given coordinate with hit mark" do
      @board.mark_board("C", 2, "X")
      expect(@board.includes_mark?("C", 2, Peg::HIT)).to be true
    end

    it "returns true given coordinate with miss mark" do
      @board.mark_board("C", 2, "O")
      expect(@board.includes_mark?("C", 2, Peg::MISS)).to be true
    end
  end
end
