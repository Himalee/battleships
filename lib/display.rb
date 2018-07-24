require_relative "console"

class Display

  def initialize(console = Console.new, message, validator)
    @console = console
    @message = message
    @validator = validator
  end

  def welcome
    @console.present(@message.welcome_message)
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

  def present_grid_showing_ship(board)
    board.each do |letter, cells|
      @console.present("#{letter} #{cells}")
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

  def user_input_row
    @console.present(@message.prompt_for_row)
  end

  def user_input_column
    @console.present(@message.prompt_for_column)
  end

  def get_valid_ship_row(size_of_board)
    rows = @validator.possible_rows
    row_for_ship = user_input_coordinate.upcase
    if !rows.include?(row_for_ship)
      prompt_for_ship_row
      get_valid_ship_row(size_of_board)
    else
      row_for_ship
    end
  end

  def get_valid_ship_column(ship_size)
    columns = @validator.valid_column(ship_size)
    column_for_ship = user_input_coordinate.to_i
    if !columns.include?(column_for_ship)
      prompt_for_ship_column
      get_valid_ship_column(ship_size)
    else
      column_for_ship
    end
  end

  def user_input_coordinate
    @console.receive
  end

  def prompt_for_ship_row
    @console.present(@message.prompt_for_ship_row)
  end

  def prompt_for_ship_column
    @console.present(@message.prompt_for_ship_column)
  end

  def get_valid_coordinates(ship_length, board)
    coordinates = get_right_direction_coordinates(ship_length, board)
    if @validator.coordinates_do_not_include_ship?(coordinates)
      coordinates
    else
      incorrect_ship_coordinate
      get_valid_coordinates(ship_length, board)
    end
  end

  def get_right_direction_coordinates(ship_size, board)
    coordinates = []
    display_ship_size(ship_size)
    row = get_row(board)
    coordinates << row
    first_column = get_first_column(ship_size)
    coordinates << extract_coordinates(board, row, first_column, ship_size)
    coordinates.flatten
  end

  def incorrect_ship_coordinate
    @console.present(@message.invalid_coordinate)
  end

  def get_row(board)
    prompt_for_ship_row
    get_valid_ship_row(board.size_of_board)
  end

  def get_first_column(ship_size)
    prompt_for_ship_column
    get_valid_ship_column(ship_size)
  end

  def extract_coordinates(board, row, first_column, ship_size)
    row = board.grid[row]
    row.slice(first_column - 1, ship_size)
  end

  def display_ship_size(ship_length)
    @console.present(@message.ship_length(ship_length))
  end

  def present_winning_message
    @console.present(@message.winning_message)
  end

  def present_retry_message
    @console.present(@message.retry_message)
  end

  def present_hit_boat_message
    @console.present(@message.hit_message)
  end

  def present_goodbye_message
    @console.present(@message.goodbye)
  end
end
