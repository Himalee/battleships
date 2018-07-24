class Player

  CARRIER = 5
  BATTLE_SHIP = 4
  CRUISER = 3
  SUBMARINE = 3
  DESTROYER = 2

  def initialize(board)
    @board = board
  end

  def generate_ships
    place_ship(CARRIER)
    place_ship(BATTLE_SHIP)
    place_ship(CRUISER)
    place_ship(SUBMARINE)
    place_ship(DESTROYER)
  end
end
