class ComputerPlayer

  def initialize(board, validator)
    @board = board
    @validator = validator
  end

  def generate_ships
    randomly_place_ship(Ship.new.carrier)
    randomly_place_ship(Ship.new.battle_ship)
    randomly_place_ship(Ship.new.cruiser)
    randomly_place_ship(Ship.new.submarine)
    randomly_place_ship(Ship.new.destroyer)
  end

  def randomly_place_ship(ship_length)
    if @validator.valid_ship?(ship_length)
      coordinates = get_valid_coordinates(ship_length)
      @board.mark_board_with_ship(coordinates)
    end
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
    random_column = @validator.valid_column(ship_size)
    random_row = @validator.possible_rows.sample
    column_options << random_row
    length_of_boat = 0
    until length_of_boat == ship_size
      column_options << random_column
      random_column += 1
      length_of_boat += 1
    end
    column_options
  end
end
