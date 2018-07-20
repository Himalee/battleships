require_relative "player"

class ComputerPlayer < Player

  def initialize(board, validator)
    super(board)
    @validator = validator
  end

  def place_ship(ship_length)
    coordinates = get_valid_coordinates(ship_length)
    @board.mark_board_with_ship(coordinates)
  end

  def get_valid_coordinates(ship_size)
    coordinates = get_right_direction_coordinates(ship_size)
    if @validator.coordinates_do_not_include_ship?(coordinates)
      coordinates
    else
      get_valid_coordinates(ship_size)
    end
  end

  def get_right_direction_coordinates(ship_size)
    column_options = []
    first_column = @validator.valid_column(ship_size).sample
    random_row = @validator.possible_rows.sample
    column_options << random_row
    column = @board.grid[random_row]
    columns = column.slice(first_column - 1, ship_size)
    column_options << columns
    column_options.flatten
  end
end
