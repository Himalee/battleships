class Board

  attr_reader :dimension, :grid

  def initialize(dimension)
    @dimension = dimension
    @grid = create_grid
  end

  def create_grid
    possible_rows.inject({}) do |result, element|
      result[element] = possible_columns
      result
    end
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

  def includes_mark?(row, column, mark)
    coordinate = @grid[row][column - 1]
    coordinate == mark
  end

  def hit_all?(grid_with_ships)
    marks = grid_with_ships.values.flatten
    !marks.include?(ship_mark)
  end

  def mark_board_with_ship(coordinates)
    columns = coordinates.drop(1)
    columns.each do |column|
      mark_board(coordinates[0], column, ship_mark)
    end
    @grid
  end
end
