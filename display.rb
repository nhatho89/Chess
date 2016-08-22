require_relative "Board"
require 'colorize'
require_relative 'cursorable'


class Display
  include Cursorable
  attr_reader :board, :notifications
  def initialize(board)
    @board = board
    @cursor_pos = [0, 0]
    @notifications = {}
  end

  def render
    system "clear"
    @board.board.each_with_index do |row,idx1|
      row.each_with_index do |piece,idx2|
        if @cursor_pos.first == idx1 && @cursor_pos.last == idx2
          print @board.board[@cursor_pos.first][@cursor_pos.last].symbol.colorize(:background => :red)
        elsif (idx1 + idx2).even?
          print piece.symbol.colorize(:color => piece.color.to_sym, :background => :magenta)
        elsif (idx1 + idx2).odd?
          print piece.symbol.colorize(:color => piece.color.to_sym, :background => :blue)
        end
      end
      print "\n"
    end
    
    @notifications.each do |key, val|
      puts "#{val}"
    end

  end

  def reset!
    @notifications.delete(:error)
  end

  def set_check!
    @notifications[:check] = "Check!"
  end

  def uncheck!
    @notifications.delete(:check)
  end

end
