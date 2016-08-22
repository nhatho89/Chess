require_relative 'board'
require_relative 'human_player'
require_relative 'display'
require 'byebug'

class Game
  attr_reader :board, :display, :players, :current_player

  def initialize
    @board = Board.new
    @display = Display.new(@board)
    @players = {
      white: HumanPlayer.new(:white, @display),
      black: HumanPlayer.new(:black, @display)
    }
    @current_player = :white
  end

  def play
    until @board.checkmate?(current_player)
      begin
        from_pos, to_pos = players[current_player].make_move(board)
        board.move_piece(current_player, from_pos, to_pos)
  #
        swap_turn!
        notify_players
      rescue StandardError => e
        @display.notifications[:error] = e.message
        retry
      end
    end

    @display.render
    puts "#{current_player} is checkmated."

    nil
  end

  def notify_players
    if @board.in_check?(current_player)
      @display.set_check!
    else
      @display.uncheck!
    end
  end

  def swap_turn!
    if @current_player == :white
      @current_player = :black
    else
      @current_player = :white
    end
  end

end


if __FILE__ == $PROGRAM_NAME
  game = Game.new
  p game.play
end
