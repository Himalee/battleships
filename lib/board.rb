class Board

  attr_reader :dimension, :grid

  def initialize(dimension)
    @dimension = dimension
    @grid = create_grid
  end

  def create_grid
    possible_rows.inject({}) { |result, element| result[element] = possible_columns; result }
  end

  def size_of_board
    Math.sqrt(@dimension)
  end

  def possible_rows
    alphabet = ("A".."Z").to_a
    alphabet[0..size_of_board - 1]
  end

  def possible_columns
    (1..size_of_board).to_a
  end

  def place_ships_on_grid(ship_mode)
    if ship_mode == 1
      grid_with_one_hardcoded_ship
    elsif ship_mode == 2
      grid_with_one_random_ship
    end
  end

  def grid_with_one_random_ship
    right_direction_mark_board(Ship.new.random_ship)
  end

  def grid_with_one_hardcoded_ship
    mark_board("C", 2, ship_mark)
    mark_board("C", 3, ship_mark)
    @grid
  end

  def mark_board(row, column, mark)
    @grid[row][column - 1] = mark
    @grid
  end

  def ship_mark
    Peg.new.ship
  end

  def hit?(grid_with_ships, row, column)
    coordinate = grid_with_ships[row][column - 1]
    coordinate == ship_mark
  end

  def hit_all?(grid_with_ships)
    marks = grid_with_ships.values.flatten
    !marks.include?(ship_mark)
  end

  def random_row
    possible_rows.sample
  end

  def random_column
    possible_columns.sample
  end

  def right_direction_valid_columns(ship_size)
    restriction = ship_size - 1
    valid_columns = possible_columns[0...-restriction]
    random_column = valid_columns.sample
    column_options = []
    length_of_boat = 0
    until length_of_boat == ship_size
      column_options << random_column
      random_column += 1
      length_of_boat += 1
    end
    column_options
  end

  def right_direction_mark_board(ship_size)
    row = random_row
    possible_columns = right_direction_valid_columns(ship_size)
    column_coordinate = 0
    until column_coordinate == ship_size
      mark_board(row, possible_columns[column_coordinate], ship_mark)
      column_coordinate += 1
    end
    @grid
  end
end
