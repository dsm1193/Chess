require_relative 'piece'

class Queen < Piece
  include SlidingPiece
  def initialize(pos=nil, color=nil,board=nil, symbol="\u2655")
    super
    @symbol = "\u265B" if @color == :b
  end

  def move_dirs
    diagonal_dirs + horizontal_dirs
  end
end
