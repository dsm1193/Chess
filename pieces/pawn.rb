require_relative 'piece'
require 'byebug'

class Pawn < Piece

  MOVES = {
    up: [-1, 0],
    down: [1, 0],
  }

  def initialize(pos, color, board, symbol="\u2659")
    super
    @symbol = "\u265F" if @color == :b
    board.add_piece(self, pos)

  end

  def moves
    forward_moves + diagonal_attacks
  end

  def at_start_row?
    ( pos.first == 1 && @color == :b ) ||
      ( pos.first == 6 && @color == :w )
  end

  def forward_dir
    color == :b ? 1 : -1
  end

  def forward_moves
    i, j = pos
    single_jump = [i + forward_dir, j]
    return [] unless board.valid_pos?(single_jump) && board.empty?(single_jump)

    steps = [single_jump]
    double_jump = [ (i + 2 * forward_dir), j]
    steps << double_jump if at_start_row? && board.empty?(double_jump)
    steps
  end

  def diagonal_attacks
    i, j = pos
    side_moves = [[i + forward_dir, j - 1], [i + forward_dir, j + 1]]
    good_moves = []
    side_moves.each do |plot|
      good_moves << plot if @board.valid_pos?(pos) && (!@board[plot].nil?) && @board[plot].color != @color
    end
    good_moves

  end

  def move_dirs
   up_dirs
  end

 def up_dirs
   return MOVES[:up] if @color == :w
   return MOVES[:down] if @color == :b
 end

end
