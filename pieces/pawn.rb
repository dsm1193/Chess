require_relative 'piece'
require 'byebug'

class Pawn < Piece

  MOVES = {
    up: [-1, 0],
    down: [1, 0],
  }

  def initialize(pos=nil, color=nil,board=nil, symbol="\u2659")
    super
    @symbol = "\u265F" if @color == :b
  end

  def moves
    up_dirs + diagonal_attacks
  end

  def at_start_row?
    ( pos.first == 1 && @color == :b ) ||
      ( pos.first == 6 && @color == :w )
  end

  def forward_step
    color == :b ? 1 : -1
  end

  def diagonal_attacks
    i, j = pos
    side_moves = [[i + forward_step, j - 1], [i + forward_step, j + 1]]
    valid_moves = []
    side_moves.each do |plot|
      valid_moves << plot if @board.valid_pos?(pos) && !@board[plot].empty? && @board[plot].color != @color
    end
    valid_moves
  end


  def move_dirs
    up_dirs
  end

  def up_dirs
    return MOVES[:up] if @color == :w
    return MOVES[:down] if @color == :b
  end


end
