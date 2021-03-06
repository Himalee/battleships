class CoordinateValidator

  def initialize(board)
    @board = board
  end

  def valid_ship?(ship_size)
    ship_size <= @board.size_of_board
  end

  def valid_column(ship_size)
    restriction = ship_size - 1
    possible_columns[0...-restriction]
  end

  def possible_columns
    (1..@board.size_of_board).to_a
  end

  def possible_rows
    alphabet = ("A".."Z").to_a
    alphabet[0..@board.size_of_board - 1]
  end

  def coordinates_do_not_include_ship?(coordinates)
    !coordinates.include?(ship_mark)
  end

  def ship_at?(location)
    ships.any? { |ship| ship.at?(location)}
  end

  def ship_mark
    Peg.new.ship
  end
end
