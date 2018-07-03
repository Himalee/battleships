class Board

  def create_grid_using_hashes(dimension)
    size = Math.sqrt(dimension)
    grid = {}
    alphabet = ("A".."Z").to_a
    letters = alphabet[0..size - 1]
    for letter in letters
      numbers = (1..size).to_a
      grid[letter] = numbers
    end
    grid
  end

  def mark_board(grid, row, column, mark)
    new_column = column - 1
    grid[row][new_column] = mark
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

  def hit_or_miss(grid_with_ships, coordinate)
    if coordinate == ship_mark
      "hit"
    else
      "miss"
    end
  end
end
