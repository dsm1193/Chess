require_relative 'piece'

class NullPiece < Piece

  require 'singleton'

  include Singleton

  def initialize(pos=nil, color=nil,board=nil, symbol=nil)
    super
  end

  def moves
  end

  def symbol
    @symbol = nil
  end
end
