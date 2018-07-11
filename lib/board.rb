class Board

  attr_reader :dimension, :grid

  def initialize(dimension)
    @dimension = dimension
    @grid = create_grid
  end

  def create_grid
    size = Math.sqrt(@dimension)
    alphabet = ("A".."Z").to_a
    letters = alphabet[0..size - 1]
    letters.inject({}) { |result, element| result[element] = (1..size).to_a; result }
  end

  def grid_with_ships
    grid_with_one_ship
  end

  def grid_with_one_ship
    mark_board("C", 2, ship_mark)
    mark_board("C", 3, ship_mark)
    @grid
  end

  def random_row
    size = Math.sqrt(@dimension)
    alphabet = ("A".."Z").to_a
    letters = alphabet[0..size - 1]
    letters.sample
  end

  def random_column
    size = Math.sqrt(@dimension)
    numbers = (1..size).to_a
    numbers.sample
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
end
