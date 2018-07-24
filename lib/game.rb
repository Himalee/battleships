require_relative "message"
require_relative "console"
require_relative "display"
require_relative "board"
require_relative "peg"
require_relative "computer_player"
require_relative "human_player"


class Game

  attr_reader :row, :column

  HARDCODED_MODE = 1
  COMPUTER_PLACES_SHIPS = 2
  HUMAN_PLACES_SHIPS = 3
  HUMAN_PLAYER = 4
  COMPUTER_PLAYER = 5

  def initialize(display, board)
    @display = display
    @board = board
  end

  def play(ship_mode, player_mode)
    welcome
    place_ships_on_grid(ship_mode)
    present_board(@board.grid)
    until @board.hit_all?(@board.grid)
      turn(player_mode, @board.grid)
    end
    goodbye
  end

  def place_ships_on_grid(ship_mode)
    if ship_mode == HARDCODED_MODE
      @board.grid_with_one_hardcoded_ship
    elsif ship_mode == COMPUTER_PLACES_SHIPS
      validator = CoordinateValidator.new(@board)
      computer_player = ComputerPlayer.new(@board, validator)
      computer_player.generate_ships
    elsif ship_mode == HUMAN_PLACES_SHIPS
      human_player = HumanPlayer.new(@board, @display)
      human_player.generate_ships
    end
  end

  def turn(player_mode, grid)
    if player_mode == HUMAN_PLAYER
      get_coordinates
      present_marked_board
    elsif player_mode == COMPUTER_PLAYER
      get_computer_coordinates
      present_marked_board
      sleep(2)
    end
  end

  def present_marked_board
    mark_board_with_hit_or_miss
    present_board(@board.grid)
    win_or_retry_message
  end

  def get_computer_coordinates
    @row = @board.possible_rows.sample
    @column = @board.possible_columns.sample
    if @board.includes_mark?(@row, @column, Peg.new.hit)
      get_computer_coordinates
    elsif @board.includes_mark?(@row, @column, Peg.new.miss)
      get_computer_coordinates
    end
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
    @display.valid_row(@board.size_of_board)
  end

  def get_column
    @display.valid_column(@board.size_of_board)
  end

  def state_of_board(mark)
    @board.mark_board(@row, @column.to_i, mark)
  end

  def mark_board_with_hit_or_miss
    if @board.includes_mark?(@row, @column.to_i, Peg.new.ship)
      state_of_board(Peg.new.hit)
    else
      state_of_board(Peg.new.miss)
    end
  end

  def win_or_retry_message
    if @board.hit_all?(@board.grid)
      @display.present_winning_message
    elsif @board.includes_mark?(@row, @column.to_i, Peg.new.hit)
      @display.present_hit_boat_message
    else
      @display.present_retry_message
    end
  end

  def goodbye
    @display.present_goodbye_message
  end
end
