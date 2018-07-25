require_relative 'piece'
require_relative 'move_modules'

class Knight < Piece
  include SteppingPiece

  def move_diffs
    [[-2, -1],
     [-1, -2],
     [-2, 1],
     [-1, 2],
     [1, -2],
     [2, -1],
     [1, 2],
     [2, 1]]
  end

  def initialize(pos=nil, color=nil,board=nil, symbol="\u2658")
    super
    @symbol = "\u265E" if @color == :b
  end

end
