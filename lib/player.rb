require_relative "ship"

class Player

  def initialize(board)
    @board = board
  end

  def generate_ships
    place_ship(Ship::CARRIER)
    place_ship(Ship::BATTLE_SHIP)
    place_ship(Ship::CRUISER)
    place_ship(Ship::SUBMARINE)
    place_ship(Ship::DESTROYER)
  end
end
