require_relative 'display'

class HumanPlayer
  attr_reader :color, :display

  def initialize(color, display)
    @color = color
    @display = display
  end

  def make_move(board)
    from, to = nil, nil

    until from && to
      display.render
      if from
        puts "Where do you want to move to?"
        to = display.get_input

      else
        puts "Where do you want to move from?"
        from = display.get_input
      end
    end

    [from,to]
  end


end
