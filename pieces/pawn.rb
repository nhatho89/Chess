require_relative 'piece'

class Pawn < Piece
  def symbol
    ' ♟ '.colorize(color)
  end

  def moves
    forward_steps + side_attacks
  end

  private

  def at_start_row?
    pos[0] == ((color == :white) ? 6 : 1)
  end

  def forward_dir
    # determines piece direction
    (color == :white) ? -1 : 1
  end

  def forward_steps
    i, j = pos
    # one position ahead of pawn
    one_step = [i + forward_dir, j]
    #checks to make sure one step ahead is within board boundaries and empty
    return [] unless board.valid_pos?(one_step) && board.empty?(one_step)
    #adds to array of possible move if valid
    steps = [one_step]

    two_step = [i + 2 * forward_dir, j]
    steps << two_step if at_start_row? && board.empty?(two_step)
    steps
  end

  def side_attacks
    i, j = pos

    side_moves = [[i + forward_dir, j - 1], [i + forward_dir, j + 1]]

    side_moves.select do |new_pos|
      #not selected if invalid position
      next false unless board.valid_pos?(new_pos)
      #not selected if pos is empty
      next false if board.empty?(new_pos)

      # selects a piece if it is at the position and it is not the same color
      threatened_piece = board[new_pos]
      threatened_piece && threatened_piece.color != color
    end
  end
end
