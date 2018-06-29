class Game

  def initialize(display, board)
    @display = display
    @board = board
  end

  def play
    welcome
    present_board
    board_with_ship
    get_coordinates
    coordinate = board_with_ship[@row][@column.to_i]
    outcome = @board.hit_or_miss(board_with_ship, coordinate)
    new_board = mark_board_with_hit_or_miss(outcome, board_with_ship)
    @display.present_initial_board(new_board)
    win?(outcome)
    replay?(outcome, new_board)
  end

  def replay?(outcome, board)
    while outcome == "miss"
      get_coordinates
      coordinate = board[@row][@column.to_i]
      outcome = @board.hit_or_miss(board, coordinate)
      new_board = mark_board_with_hit_or_miss(outcome, board)
      @display.present_initial_board(new_board)
      win?(outcome)
    end
  end

  def welcome
    @display.welcome
  end

  def present_board
    @display.present_initial_board(hash_grid)
  end

  def board_with_ship
    @board.place_ship(hash_grid)
  end

  def hash_grid
    @board.create_grid_using_hashes(100)
  end

  def get_coordinates
    @display.user_input_row
    @row = get_row
    @display.user_input_column
    @column = get_column
  end

  def get_row
    @display.user_input_coordinate
  end

  def get_column
    @display.user_input_coordinate
  end

  def state_of_board(board, mark)
    @board.mark_board(board, @row, @column.to_i, mark)
  end

  def mark_board_with_hit_or_miss(outcome, board)
    if outcome == "miss"
      state_of_board(board, @display.miss)
    else
      state_of_board(board, @display.hit)
    end
  end

  def win?(outcome)
    if outcome == "miss"
      @display.present_retry_message
    elsif outcome == "hit"
      @display.present_winning_message
    end
  end
end