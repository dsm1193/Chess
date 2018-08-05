require_relative 'piece'
require_relative 'move_modules'

class Bishop < Piece
  include SlidingPiece

  def initialize(pos, color, board, symbol="\u2657")
    super
    @symbol = "\u265D" if @color == :b
    board.add_piece(self, pos)
  end

  def move_dirs
    diagonal_dirs
  end

end
