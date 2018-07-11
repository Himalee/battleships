require "board"
require "ship"
require "peg"

describe Board do

  before :each do
    @board = Board.new(9)
  end

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
      expect(@board.grid_with_one_ship).to eql({"A"=>[1, 2, 3], "B"=>[1, 2, 3], "C"=>[1, "-", "-"]})
    end
  end

  context "grid with one ship" do
    it "given missed coordinate, returns false" do
      expect(@board.hit?(@board.grid_with_one_ship, "A", 1)).to be false
      expect(@board.hit?(@board.grid_with_one_ship, "C", 1)).to be false
    end

    it "given a hit coordinate, returns true" do
      expect(@board.hit?(@board.grid_with_one_ship, "C", 2)).to be true
      expect(@board.hit?(@board.grid_with_one_ship, "C", 3)).to be true
    end

    it "given all hit coordinates, returns true" do
      @board.grid_with_one_ship
      @board.mark_board("C", 2, "X")
      @board.mark_board("C", 3, "X")
      expect(@board.hit_all?(@board.grid)).to be true
    end

    it "not given all hit coordinates, returns false" do
      @board.grid_with_one_ship
      @board.mark_board("C", 2, "X")
      expect(@board.hit_all?(@board.grid)).to be false
    end
  end
end
