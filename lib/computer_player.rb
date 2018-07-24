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
    coordinates = []
    first_column = @validator.valid_column(ship_size).sample
    random_row = @validator.possible_rows.sample
    coordinates << random_row
    coordinates << extract_coordinates(random_row, first_column, ship_size)
    coordinates.flatten
  end

  def extract_coordinates(random_row, first_column, ship_size)
    row = @board.grid[random_row]
    row.slice(first_column - 1, ship_size)
  end

  def get_coordinate_guess
    coordinates = []
    @row = @board.possible_rows.sample
    @column = @board.possible_columns.sample
    if @board.includes_mark?(@row, @column, Peg::HIT)
      get_coordinate_guess
    elsif @board.includes_mark?(@row, @column, Peg::MISS)
      get_coordinate_guess
    end
    coordinates << @row
    coordinates << @column
  end
end
