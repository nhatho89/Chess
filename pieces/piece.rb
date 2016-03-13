require 'singleton'

class Piece

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
