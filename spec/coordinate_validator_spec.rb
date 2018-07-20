require "coordinate_validator"

describe CoordinateValidator do

  before :each do
    @board = Board.new(4)
    @validator = CoordinateValidator.new(@board)
  end

  let(:coordinates) { ["A", 1, 2] }

  it "returns true given valid coordinates" do
    expect(@validator.coordinates_do_not_include_ship?(coordinates)).to be true
  end

  it "returns false given invalid coordinates test" do
    @board.mark_board_with_ship(coordinates)
    expect(@validator.coordinates_do_not_include_ship?(["A", "-", "-"])).to be false
  end
end
