class Message

  def welcome_message
    "Welcome to Battleships! 🚢  ⛵  🛥\nA ship has been placed on the board:"
  end

  def prompt_for_row
    "Please choose a coordinate\nRow (letter):"
  end

  def prompt_for_column
    "Column (number):"
  end

  def winning_message
    "The ships have been sunk 💣  You win!! 🎉"
  end

  def losing_message
    "The ship survives 🚢  You lose!!"
  end

  def retry_message
    "You missed, try again.."
  end

  def hit_message
    "You have hit a boat, keep trying.."
  end

  def goodbye
    "Goodbye 👋"
  end

  def prompt_for_ship_row
    "To place the ship on the board, please choose a row"
  end

  def prompt_for_ship_column
    "To place the ship on the board, please choose a column"
  end

  def invalid_coordinate
    "A ship has already been placed here, choose another coordinate"
  end

  def ship_length(ship_length)
    "The ship length is #{ship_length}"
  end
end
