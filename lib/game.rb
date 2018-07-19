require_relative "messages"
require_relative "console"
require_relative "display"
require_relative "board"
require_relative "peg"
require_relative "computer_player"


class Game
  HARDCODED_MODE = 1
  COMPUTER_MODE = 2
  def initialize(display, board)
    @display = display
    @board = board
  end

  def play(ship_mode)
    welcome
    place_ships_on_grid(ship_mode)
    present_board(@board.grid)
    until @board.hit_all?(@board.grid)
      turn(@board.grid)
    end
    goodbye
  end

  def place_ships_on_grid(ship_mode)
    if ship_mode == HARDCODED_MODE
      @board.grid_with_one_hardcoded_ship
    elsif ship_mode == COMPUTER_MODE
      validator = CoordinateValidator.new(@board)
      computer_player = ComputerPlayer.new(@board, validator)
      computer_player.generate_ships
    end
  end

  def turn(grid)
    get_coordinates
    mark_board_with_hit_or_miss
    present_board(@board.grid)
    win_or_retry_message
  end

  def welcome
    @display.welcome
  end

  def present_board(grid)
    @display.present_board(grid)
  end

  def get_coordinates
    @display.user_input_row
    @row = get_row
    @display.user_input_column
    @column = get_column
  end

  def get_row
    @display.valid_row(Math.sqrt(@board.dimension))
  end

  def get_column
    @display.valid_column(Math.sqrt(@board.dimension))
  end

  def state_of_board(mark)
    @board.mark_board(@row, @column.to_i, mark)
  end

  def mark_board_with_hit_or_miss
    if @board.hit?(@board.grid, @row, @column.to_i)
      state_of_board(Peg.new.hit)
    else
      state_of_board(Peg.new.miss)
    end
  end

  def win_or_retry_message
    if @board.hit_all?(@board.grid)
      @display.present_winning_message
    elsif @board.hit?(@board.grid, @row, @column.to_i)
      @display.present_hit_boat_message
    else
      @display.present_retry_message
    end
  end

  def goodbye
    @display.present_goodbye_message
  end
end
