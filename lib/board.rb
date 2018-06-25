class Board

  def create_grid_using_hashes(dimension)
    size = Math.sqrt(dimension)
    grid = {}
    alphabet = ("A".."Z").to_a
    letters = alphabet[0..size - 1]
    for letter in letters
      grid[letter] = (1..size).to_a
    end
    grid
  end

  def mark_board(grid, row, column)
    new_column = column - 1
    grid[row][new_column] = "-"
    grid
  end
end
