require_relative 'piece'


class King < Piece
  include SteppingPiece
  def initialize(pos, color, board, symbol="\u2654")
    super
    @symbol = "\u265A" if @color == :b
    board.add_piece(self, pos)
  end

  def move_diffs
    [[-1, -1], [-1, 0], [-1, 1], [0, -1], [0, 1], [1, -1], [1, 0], [1, 1]]
  end
end
