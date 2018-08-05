require_relative 'piece'

class Rook < Piece

  include SlidingPiece

  def initialize(pos, color, board, symbol="\u2656")
    super
    @symbol = "\u265C" if @color == :b
    board.add_piece(self, pos)
  end

  def move_dirs
    horizontal_dirs
  end

end
