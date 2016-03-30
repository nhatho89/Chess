module Stepping
  def moves

    moves = []
    move_diffs.each do |move|
      dx, dy = move
      cur_x, cur_y = pos
      pos = [cur_x + dx, cur_y + dy]

      next unless board.in_bounds?(pos)

      if board.empty?(pos)
        #moves here if empty
        moves << pos
      elsif board[pos].color != color
        #moves here if piece on there is not the same color
        moves << pos
      end
    end
    moves
  end

  private

  def move_diffs
    # subclass implements this
    raise NotImplementedError
  end
end
