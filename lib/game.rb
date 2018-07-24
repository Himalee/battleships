require_relative "message"
require_relative "console"
require_relative "display"
require_relative "board"
require_relative "peg"
require_relative "computer_player"
require_relative "human_player"


class Game

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
      human_player = HumanPlayer.new(@board, @display)
      coordinates = human_player.get_coordinate_guess
      present_marked_board(coordinates)
    elsif player_mode == COMPUTER_PLAYER
      validator = CoordinateValidator.new(@board)
      computer_player = ComputerPlayer.new(@board, validator)
      coordinates = computer_player.get_coordinate_guess
      present_marked_board(coordinates)
      sleep(1)
    end
  end

  def present_marked_board(coordinates)
    mark_board_with_hit_or_miss(coordinates)
    present_board(@board.grid)
    win_or_retry_message(coordinates)
  end

  def welcome
    @display.welcome
  end

  def present_board(grid)
    @display.present_board(grid)
  end

  def mark_board(mark, coordinates)
    @board.mark_board(coordinates[0], coordinates[1], mark)
  end

  def mark_board_with_hit_or_miss(coordinates)
    if @board.includes_mark?(coordinates[0], coordinates[1], Peg::SHIP)
      mark_board(Peg::HIT, coordinates)
    else
      mark_board(Peg::MISS, coordinates)
    end
  end

  def win_or_retry_message(coordinates)
    if @board.hit_all?(@board.grid)
      @display.present_winning_message
    elsif @board.includes_mark?(coordinates[0], coordinates[1], Peg::HIT)
      @display.present_hit_boat_message
    else
      @display.present_retry_message
    end
  end

  def goodbye
    @display.present_goodbye_message
  end
end
