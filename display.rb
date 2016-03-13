require_relative "Board"
require 'colorize'
require_relative 'cursorable'


class Display
  attr_reader :board
  def initialize(board)
    @board = board
    render
  end

  def render
    system "clear"
    @board.board.each_with_index do |row,idx1|
      row.each_with_index do |piece,idx2|
        # if cursor_pos.first == idx1 && cursor_pos.last == idx2
          # print @board.board[cursor_pos.first][cursor_pos.last].symbol.colorize(:background => :red)
        # elsif (idx1 + idx2).even?
          print piece.symbol.colorize(:color => piece.color.to_sym, :background => :white)
        # elsif (idx1 + idx2).odd?
          print piece.symbol.colorize(:color => piece.color.to_sym, :background => :magenta)
        # end
      end
      print "\n"
    end

  end
end
