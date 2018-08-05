require_relative 'piece'
require 'singleton'

class NullPiece < Piece
  attr_reader :symbol

  include Singleton

  def initialize
    @symbol = ' '
    @color = :none
    # board.add_piece(self, pos)
  end

  def moves
    []
  end

  def symbol
    @symbol = nil
  end
end
