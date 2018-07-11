require_relative "console"

class Display

  def initialize(console = Console.new, message)
    @console = console
    @messages = message
  end

  def welcome
    @console.present(@messages.welcome_message)
  end

  def present_board(board)
    present_header_with_numbers(board)
    board.each do |letter, cells|
      each_row = cells.map do |cell|
        reveal(cell)
      end
    rows = each_row.join(" ")
    @console.present("#{letter} #{rows}")
    end
  end

  def present_header_with_numbers(board)
    columns = (0..board.count).to_a
    numbers = columns.join(" ")
    @console.present("#{numbers}")
  end

  def reveal(cell)
    if cell != Peg.new.miss && cell != Peg.new.hit
      Peg.new.board
    else
      cell
    end
  end

  def user_input_coordinate
    @console.receive
  end

  def user_input_row
    @console.present(@messages.prompt_for_row)
  end

  def user_input_column
    @console.present(@messages.prompt_for_column)
  end

  def valid_row(size)
    alphabet = ("A".."Z").to_a
    letter = alphabet[size - 1]
    row = user_input_coordinate.upcase
    possible_moves = ("A".."#{letter}").to_a
    if !possible_moves.include?(row)
      user_input_row
      valid_row(size)
    else
      row
    end
  end

  def valid_column(size)
    column = user_input_coordinate
    possible_moves = ("1".."#{size.to_i}").to_a
    if !possible_moves.include?(column)
      user_input_column
      valid_column(size)
    else
      column
    end
  end

  def present_winning_message
    @console.present(@messages.winning_message)
  end

  def present_retry_message
    @console.present(@messages.retry_message)
  end

  def present_hit_boat_message
    @console.present(@messages.hit_message)
  end

  def present_goodbye_message
    @console.present(@messages.goodbye)
  end
end
