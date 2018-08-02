require_relative 'move_modules'

class Piece

  attr_reader :color, :symbol, :board
  attr_accessor :pos

  def initialize(pos=nil, color=nil,board=nil, symbol=nil)
    @pos = pos
    @color = color
    @board = board
    @symbol = symbol
  end

  def to_s
    " #{symbol} "
  end

  def empty?
    self.is_a?(NullPiece)
  end

  def valid_moves
   moves.reject do |end_pos|
     move_into_check?(end_pos)
   end
  end

  #
  # private
  #
  def move_into_check?(end_pos)

    sample = board.dup
    sample.move_piece(color, pos, end_pos)
    sample.in_check?(color)

  end

end
