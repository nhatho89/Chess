require_relative 'pieces'

class Board
  attr_reader :board

  def initialize
    @board = Array.new(8) {Array.new(8, Blank.instance)}
    # populate
  end

  def move(start, end_pos)
    if @board[start[0]][start[1]].is_a? Blank
      raise "Invalid starting position!"
    else
      @board[end_pos[0]][end_pos[1]] = @board[start[0]][start[1]]
      @board[start[0]][start[1]] = Blank.instance
    end
  end

  def populate

  end

end
