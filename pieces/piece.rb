require_relative 'move_modules'

class Piece

  attr_reader :color, :symbol
  attr_accessor :pos, :board

  def initialize(pos, color, board, symbol)
#     raise 'invalid color' unless %i(w b).include?(color)
# raise 'invalid pos' unless board.valid_pos?(pos)
    @pos = pos
    @color = color
    @board = board
    @symbol = symbol

    board.add_piece(self, pos)
  end

  def to_s
    " #{symbol} "
  end

  def empty?
    self.is_a?(NullPiece)
  end

  def valid_moves
   moves.reject { |end_pos| move_into_check?(end_pos) }
  end

  def move_into_check?(end_pos)

    sample = board.dup
    sample.move_piece!(pos, end_pos)
    sample.in_check?(color)
  end

end
