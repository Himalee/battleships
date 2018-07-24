class Player

  def initialize(board)
    @board = board
  end

  def generate_ships
    place_ship(Ship.new.carrier)
    place_ship(Ship.new.battle_ship)
    place_ship(Ship.new.cruiser)
    place_ship(Ship.new.submarine)
    place_ship(Ship.new.destroyer)
  end

  def place_ship
  end
end
