require_relative 'piece'
require_relative 'sliding'

class Rook < Piece
  include Sliding

  def symbol
    ' ♜ '.colorize(color)
  end

  protected

  def move_dirs
    horizontal_dirs
  end
end
