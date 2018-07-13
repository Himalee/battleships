class Ship
  def carrier
    5
  end

  def battle_ship
    4
  end

  def cruiser
    3
  end

  def submarine
    3
  end

  def destroyer
    2
  end

  def random_ship
    ships = []
    ships += [carrier, battle_ship, cruiser, submarine, destroyer]
    ships.sample
  end
end
