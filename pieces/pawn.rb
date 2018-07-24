require_relative 'piece'

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
    up + diagonal_attacks
  end

  def at_start_row?
    ( pos.first == 1 && @color == :b ) ||
      ( pos.first == 6 && @color == :w )
  end

  def forward_step
    color == :b ? 1 : -1
  end

  def diagonal_attacks
    # if @color == :b
    #   [[pos.first+1, pos.last+1],[pos.first+1, pos.last-1]]
    # else
    #   [[pos.first-1,pos.last+1],[pos.first-1,pos.last-1]]
    # end
    i, j = pos
    side_moves = [[i + forward_step, j - 1], [i + forward_step, j + 1]]
    valid_moves = []
    side_moves.inject { |accum, plot| @board.valid_pos(plot) &&
      !@board[plot].empty? ? accum << plot : accum }
  end


  def move_dirs
    up_dirs
  end

  def up_dirs
    return MOVES[:up] if @color == :w
    return MOVES[:down] if @color == :b
  end


end
