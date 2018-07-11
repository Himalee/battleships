class Messages

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
    "The ship has been sunk 💣  You win!! 🎉"
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
end
