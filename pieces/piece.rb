require 'singleton'

class Piece

  attr_reader :board, :color
  attr_accessor :pos

  def initialize(color, board, pos)
    raise 'invalid color' unless [:white, :black].include?(color)
    # raise 'invalid pos' unless board.valid_pos?(pos)

    @color = color
    @board = board
    @pos = pos

    @board.add_piece(self, pos)
  end

  def to_s
    " #{symbol} "
  end

  def empty?
    false
  end

  def symbol
    # subclass implements this with unicode chess char
    raise NotImplementedError
  end

  def valid_moves
    moves.reject { |to| move_into_check?(to) }
  end

  private

  def move_into_check?(to)
    test_board = board.dup
    test_board.move_piece!(pos, to)
    test_board.check?(color)
  end

end


class Blank
  include Singleton

  def initialize
  end

  def moves
    []
  end

  def color
    :none
  end

  def symbol
    "   "
  end

  def empty?
    true
  end
end
