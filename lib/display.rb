require_relative "console"

class Display

  def initialize(console)
    @console = console
  end

  def present_board(board)
    columns = (0..board.count).to_a
    numbers = columns.join(" ")
    @console.present("#{numbers}")
    board.each do |key, value|
      each_row = value.map do |number|
        "."
      end
      dots = each_row.join(" ")
      @console.present("#{key} #{dots}")
    end
  end
end
