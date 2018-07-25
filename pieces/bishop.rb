require_relative 'piece'
require_relative 'move_modules'

class Bishop < Piece
  include SlidingPiece

  def initialize(pos=nil, color=nil,board=nil, symbol="\u2657")
    super
    @symbol = "\u265D" if @color == :b
  end

  def move_dirs
    diagonal_dirs
  end

end
