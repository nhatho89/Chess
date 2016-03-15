module Stepping
  def moves
    move_diffs.each do |move|
      dx, dy = move
      cur_x, cur_y = pos
      pos = [cur_x + dx, cur_y + dy]

      next unless board.valid_pos?(pos)

      if board.empty?(pos)
        #moves here if empty
        return pos
      elsif board[pos].color != color
        #moves here if piece on there is not the same color
        return pos
      end
    end
  end

  private

  def move_diffs
    # subclass implements this
    raise NotImplementedError
  end
end
