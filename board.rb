require_relative 'pieces'
require 'byebug'

class Board
  attr_reader :board

  def initialize
    @blank = Blank.instance
    populate_grid
  end

  def move(start, end_pos)
    if @board[start[0]][start[1]].is_a? Blank
      raise "Invalid starting position!"
    else
      @board[end_pos[0]][end_pos[1]] = @board[start[0]][start[1]]
      @board[start[0]][start[1]] = Blank.instance
    end
  end

  def populate_back_row(color)
    # debugger
    row = (color == :white) ? 7 : 0
    pieces = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]

    pieces.each_with_index do |piece, col|
      piece.new(color, self, [row,col])
    end

  end

  def add_piece(piece, pos)
    # debugger
    i, j = pos
    @board[i][j] = piece
  end

  def populate_pawn(color)

    row = (color == :white) ? 6 : 1
    8.times do |col|
      Pawn.new(color, self, [row,col])
    end
  end

  def populate_grid
      @board = Array.new(8) {Array.new(8, Blank.instance)}
      [:white, :black].each do |color|
        populate_back_row(color)
        populate_pawn(color)
      end
  end

end
