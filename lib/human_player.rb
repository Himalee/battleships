require_relative "player"

class HumanPlayer < Player

  def initialize(board, display)
    super(board)
    @display = display
  end

  def place_ship(ship_length)
    coordinates = @display.get_valid_coordinates(ship_length, @board)
    @board.mark_board_with_ship(coordinates)
    @display.present_grid_showing_ship(@board.grid)
  end

  def get_coordinate_guess
    coordinates = []
    @display.user_input_row
    row = get_row
    @display.user_input_column
    column = get_column
    coordinates << row
    coordinates << column.to_i
  end

  def get_row
    @display.valid_row(@board.size_of_board)
  end

  def get_column
    @display.valid_column(@board.size_of_board)
  end
end
