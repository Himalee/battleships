require_relative "console"

class Display

  def initialize(console = Console.new, message)
    @console = console
    @messages = message
  end

  def welcome
    @console.present(@messages.welcome_message)
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

  def present_initial_board(board)
    present_header(board)
    board.each do |letter, cells|
      each_row = cells.map do |cell|
        reveal(cell)
      end
    rows = each_row.join(" ")
    @console.present("#{letter} #{rows}")
    end
  end

  def reveal(cell)
    if cell != @messages.miss_mark && cell != @messages.hit_mark
      @messages.board_mark
    else
      cell
    end
  end

  def present_header(board)
    columns = (0..board.count).to_a
    numbers = columns.join(" ")
    @console.present("#{numbers}")
  end

  def present_winning_message
    @console.present(@messages.winning_message)
  end

  def present_retry_message
    @console.present(@messages.retry_message)
  end

  def miss
    @messages.miss_mark
  end

  def hit
    @messages.hit_mark
  end
end
