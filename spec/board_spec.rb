require "board"

describe Board do

  before :each do
    @board = Board.new
  end

  it "returns hash of 9x9 grid" do
    dimension = 9
    expect(@board.create_grid(dimension)).to eql({"A"=>[1, 2, 3], "B"=>[1, 2, 3], "C"=>[1, 2, 3]})
  end

  it "returns hash of 2x2 grid" do
    dimension = 4
    expect(@board.create_grid(dimension)).to eql({"A"=>[1, 2], "B"=>[1, 2]})
  end

  context "returns new hash" do
    it "given coordinate A1" do
      grid = {"A"=>[1, 2, 3], "B"=>[1, 2, 3], "C"=>[1, 2, 3]}
      expect(@board.mark_board(grid, "A", 1, "-")).to eql({"A"=>["-", 2, 3], "B"=>[1, 2, 3], "C"=>[1, 2, 3]})
    end

    it "given coordinate C2" do
      grid = {"A"=>[1, 2, 3], "B"=>[1, 2, 3], "C"=>[1, 2, 3]}
      expect(@board.mark_board(grid, "C", 2, "-")).to eql({"A"=>[1, 2, 3], "B"=>[1, 2, 3], "C"=>[1, "-", 3]})
    end

    it "given 2 coordinates C2 & C3 placing ship on board" do
      grid = {"A"=>[1, 2, 3], "B"=>[1, 2, 3], "C"=>[1, 2, 3]}
      expect(@board.place_ship(grid)).to eql({"A"=>[1, 2, 3], "B"=>[1, 2, 3], "C"=>[1, "-", "-"]})
    end
  end

  it "returns miss" do
    grid_with_ships = {"A"=>[1, 2, 3], "B"=>[1, 2, 3], "C"=>[1, "-", "-"]}
    coordinate = grid_with_ships["A"][1]
    expect(@board.hit_or_miss(grid_with_ships, coordinate)).to eql("miss")
  end

  it "returns hit" do
    grid_with_ships = {"A"=>[1, 2, 3], "B"=>[1, 2, 3], "C"=>[1, "-", "-"]}
    coordinate = grid_with_ships["C"][2]
    expect(@board.hit_or_miss(grid_with_ships, coordinate)).to eql("hit")
  end

end
