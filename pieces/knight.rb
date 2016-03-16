require_relative 'piece'
require_relative 'stepping'

class Knight < Piece
  include Stepping

  def symbol
    ' ♞ '.colorize(color)
  end

  protected

  def move_diffs
    [[-2, -1],
     [-1, -2],
     [-2, 1],
     [-1, 2],
     [1, -2],
     [2, -1],
     [1, 2],
     [2, 1]]
  end
end
