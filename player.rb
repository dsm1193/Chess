require_relative 'display'

class Player

  attr_reader :color, :display

  def initialize(color, display)
    @color, @display = color, display
  end

  def make_move(board)
    from, to = nil, nil

    until from && to
      display.render
      player = nil
      color == :b ? player = "Black" : player = "White"
      if from
        puts "#{player}'s turn. Where would you like to place?"
        to = display.change_cursor
      else
        puts "#{player}'s turn. Select a piece to move."
        from = display.change_cursor
      end
    end
    [from, to]
  end

end
