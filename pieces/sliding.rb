module Sliding
  HORIZONTAL_DIRS = [
    [-1, 0],
    [0, -1],
    [0, 1],
    [1, 0]
  ]

  DIAGONAL_DIRS = [
    [-1, -1],
    [-1, 1],
    [1, -1],
    [1, 1]
  ]

  def horizontal_dirs
    HORIZONTAL_DIRS
  end

  def diagonal_dirs
    DIAGONAL_DIRS
  end

  def moves
    moves = []

    move_dirs.each do |dx, dy|
      moves.concat(grow_unblocked_moves_in_dir(dx, dy))
    end

    moves
  end

  private

  def move_dirs

    # subclass implements this
    # overridden by the piece's move_dirs method
      # rook will call horizontal_dirs method which returns the constant HORIZONTAL_DIRS
    raise NotImplementedError
  end

  def grow_unblocked_moves_in_dir(dx, dy)
    cur_x, cur_y = pos
    moves = []
    loop do
      cur_x, cur_y = cur_x + dx, cur_y + dy
      pos = [cur_x, cur_y]

      break unless board.in_bounds?(pos)

      if board.empty?(pos)
        moves << pos
      else
        # can take an opponent's piece
        moves << pos if board[pos].color != color

        # can't move past blocking piece
        break
      end
    end
    moves
  end
end
