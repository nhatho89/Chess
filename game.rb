require_relative 'board'
require_relative 'player'

class Game
  attr_reader :board, :display, :current_player, :players

  def initialize
    @board = Board.new
    @display = Display.new(@board)
    # @players = {
    #   white: HumanPlayer.new(:white, @display),
    #   black: HumanPlayer.new(:black, @display)
    # }
    # @current_player = :white
  end

  def play
    @display.render
  end
end


if __FILE__ == $PROGRAM_NAME
  Game.new.play
end
