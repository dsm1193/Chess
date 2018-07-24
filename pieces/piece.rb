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

  def empty?
    self.is_a?(NullPiece)
  end

end
