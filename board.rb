require_relative 'pieces'
require 'byebug'

class Board
  attr_reader :board

  def initialize(populate_board = true)
    @blank = Blank.instance

    populate_grid if populate_board
  end

  # def move(start, end_pos)
  #   if @board[start[0]][start[1]].is_a? Blank
  #     raise "Invalid starting position!"
  #   else
  #     @board[end_pos[0]][end_pos[1]] = @board[start[0]][start[1]]
  #     @board[start[0]][start[1]] = Blank.instance
  #   end
  # end

  def [](pos)
    raise 'invalid pos' unless in_bounds?(pos)

    i, j = pos
    @board[i][j]
  end

  def []=(pos, piece)
    raise 'invalid pos' unless in_bounds?(pos)

    i, j = pos
    @board[i][j] = piece
  end

  def populate_back_row(color)
    # debugger
    row = (color == :white) ? 7 : 0
    pieces = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]

    pieces.each_with_index do |piece, col|
      piece.new(color, self, [row,col])
    end

  end

  def add_piece(piece, pos)
    raise 'position not empty' unless empty?(pos)
    i, j = pos
    # debugger
    @board[i][j] = piece
  end

  def populate_pawn(color)

    row = (color == :white) ? 6 : 1
    8.times do |col|
      Pawn.new(color, self, [row,col])
    end
  end

  def populate_grid
      @board = Array.new(8) {Array.new(8, Blank.instance)}
      [:white, :black].each do |color|
        populate_back_row(color)
        populate_pawn(color)
      end
  end

  def in_bounds?(pos)
    pos.all? { |coord| coord.between?(0, 7) }
  end

  def move_piece(current_player_color, from, to)
    raise 'from position is empty' if empty?(from)

    current_piece = @board[from[0]][from[1]]
    # debugger
    if current_player_color != current_piece.color
      raise "That is not your piece!"
    elsif !current_piece.moves.include?(to)
      raise "You cannot move there!"
    # elsif !current_piece.valid_moves.include?(to)
    #   raise 'You cannot move into check'
    end
    move_piece!(from,to)
  end

  def move_piece!(from,to)
    piece = @board[from[0]][from[1]]
    raise 'piece cannot move like that' unless piece.moves.include?(to)

    # @board[to[0]][to[1]] = @board[from[0]][from[1]]
    # @board[from[0]][from[1]] = @blank
    self[to] = piece
    self[from] = @blank
    piece.pos = to

    nil
  end

  def empty?(pos)
    @board[pos[0]][pos[1]].color == :none
  end

  def checkmate?(color)
    false
  end

  def all_pieces
    @board.flatten.reject { |piece| piece.color == :none }
  end

  def find_king(color)
    all_pieces.select { |piece| piece.color == color && piece.is_a?(King) }
  end

  def check?(color)
    # debugger
    king_pos = find_king(color).first.pos

    all_pieces.any? do |piece|
      piece.color != color && piece.moves.include?(king_pos)
    end

  end

  def dup
    new_board = Board.new(false)

    all_pieces.each do |piece|
      piece.class.new(piece.color, new_board, piece.pos)
    end

    new_board
  end

end
