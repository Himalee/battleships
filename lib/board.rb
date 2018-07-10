class Board

  def create_grid(dimension)
    size = Math.sqrt(dimension)
    alphabet = ("A".."Z").to_a
    letters = alphabet[0..size - 1]
    letters.inject({}) {|result, element| result[element] = (1..size).to_a; result }
  end

  def mark_board(grid, row, column, mark)
    grid[row][column - 1] = mark
    grid
  end

  def place_ship(grid)
    mark_board(grid, "C", 2, ship_mark)
    mark_board(grid, "C", 3, ship_mark)
    grid
  end

  def ship_mark
    "-"
  end

  def hit_or_miss(grid_with_ships, row, column)
    coordinate = grid_with_ships[row][column - 1]
    if coordinate == ship_mark
      "hit"
    else
      "miss"
    end
  end

  def hit_all(grid_with_ships)
    marks = grid_with_ships.values.flatten
    if marks.include?(ship_mark)
      "not hit all"
    else
      "hit all"
    end
  end
end
