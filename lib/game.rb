require_relative "messages"
require_relative "console"
require_relative "display"
require_relative "board"
require_relative "peg"


class Game

  def initialize(display, board)
    @display = display
    @board = board
  end

  def play
    welcome
    present_board(@board.grid_with_ships)
    until @board.hit_all?(@board.grid)
      turn(@board.grid)
    end
    goodbye
  end

  def turn(grid)
    get_coordinates
    mark_board_with_hit_or_miss
    @display.present_board(@board.grid)
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
