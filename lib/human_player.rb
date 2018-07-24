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
end
