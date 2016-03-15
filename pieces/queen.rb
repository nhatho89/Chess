require_relative 'piece'
require_relative 'sliding'

class Queen < Piece
  include Sliding

  def symbol
    '♛'.colorize(color)
  end

  protected

  def move_dirs
    diagonal_dirs + horizontal_dirs
  end
end
