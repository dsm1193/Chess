require_relative 'piece'

class Queen < Piece
  include SlidingPiece
  def initialize(pos, color, board, symbol="\u2655")
    super
    @symbol = "\u265B" if @color == :b
    board.add_piece(self, pos)
  end

  def move_dirs
    diagonal_dirs + horizontal_dirs
  end
end
