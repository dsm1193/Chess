require_relative 'piece'

class Rook < Piece

  include SlidingPiece

  def initialize(pos=nil, color=nil,board=nil, symbol="\u2656")
    super
    @symbol = "\u265C" if @color == :b
  end

  def move_dirs
    horizontal_dirs
  end

end
