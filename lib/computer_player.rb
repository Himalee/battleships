class ComputerPlayer

  def initialize(board)
    @board = board
  end

  def generate_ships
    randomly_place_ship(Ship.new.carrier)
    randomly_place_ship(Ship.new.battle_ship)
    randomly_place_ship(Ship.new.cruiser)
    randomly_place_ship(Ship.new.submarine)
    randomly_place_ship(Ship.new.destroyer)
  end

  def randomly_place_ship(ship_length)
    if valid_ship?(ship_length)
      coordinates = get_valid_coordinates(ship_length)
      mark_board_with_ship(coordinates)
    end
  end

  def valid_ship?(ship_size)
     ship_size <= @board.size_of_board
  end

  def get_valid_coordinates(ship_size)
    coordinates = get_right_direction_coordinates(ship_size)
    if coordinates_do_not_include_ship?(coordinates)
      coordinates
    else
      get_valid_coordinates(ship_size)
    end
  end

  def get_right_direction_coordinates(ship_size)
    column_options = []
    random_column = valid_column(ship_size)
    random_row = possible_rows.sample
    column_options << random_row
    length_of_boat = 0
    until length_of_boat == ship_size
      column_options << random_column
      random_column += 1
      length_of_boat += 1
    end
    column_options
  end

  def valid_column(ship_size)
    restriction = ship_size - 1
    valid_columns = possible_columns[0...-restriction]
    valid_columns.sample
  end

  def possible_columns
    (1..@board.size_of_board).to_a
  end

  def possible_rows
    alphabet = ("A".."Z").to_a
    alphabet[0..@board.size_of_board - 1]
  end

  def coordinates_do_not_include_ship?(coordinates)
    length_of_boat = coordinates.count - 1
    index = 1
    array = []
    until index > length_of_boat
      array << @board.grid[coordinates[0]][coordinates[index] - 1]
      index += 1
    end
    !array.include?(ship_mark)
  end

  def ship_mark
    Peg.new.ship
  end

  def mark_board_with_ship(coordinates)
    length_of_boat = coordinates.count - 1
    index = 1
    until index > length_of_boat
      @board.mark_board(coordinates[0], coordinates[index], ship_mark)
      index += 1
    end
    @board.grid
  end
end
