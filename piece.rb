require_relative 'move_modules'
class Piece

  attr_reader :color, :symbol, :pos

  def initialize(pos=nil, color=nil,board=nil, symbol=nil)
    @pos = []
    @color = color
    @board = board
    @symbol = symbol
  end

  def moves

  end

end


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

class Knight < Piece

  def initialize(pos=nil, color=nil,board=nil, symbol="\u2658")
    super
    @symbol = "\u265E" if @color == :b
  end
  
  def moves #knight
    row,col = @pos
    arr = []
    (-2..2).each do |jump1|
      next if jump1 == 0
      (-2..2).each do |jump2|
        next if jump2 == 0 || jump2.abs == jump1.abs
        arr << [(row+jump1), (col+jump2)]
      end
    end
    arr.reject { |plot| plot.any? { |coordinate| !coordinate.between?(0,7) } }
  end
  
  def move_diffs
  end

end

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
    up_dirs #+ side_attacks
  end
  
  def at_start_row?
    return true if pos.first == 1 && @color ==  :b
    return true if pos.first == 6 && @color == :w
    return false
  end 
  
  def forward_steps
    #deal with the color problem with this
    if at_start_row?
      [[pos.first+2, pos.last], [pos.first+1, pos.last]]
    end
  end
  
  def side_attacks
    if @color == :b
      [[pos.first+1, pos.last+1],[pos.first+1, pos.last-1]]
    else
      [[pos.first-1,pos.last+1],[pos.first-1,pos.last-1]]
    end  
  end
  
  
  def move_dirs
    up_dirs
  end
  
  def up_dirs
    return MOVES[:up] if @color == :w
    return MOVES[:down] if @color == :b
  end
  
  
end

class Bishop < Piece
  include SlidingPiece

  def initialize(pos=nil, color=nil,board=nil, symbol="\u2657")
    super
    @symbol = "\u265D" if @color == :b
  end

  def move_dirs
    diagonal_dirs
  end
end

class Queen < Piece
  include SlidingPiece
  def initialize(pos=nil, color=nil,board=nil, symbol="\u2655")
    super
    @symbol = "\u265B" if @color == :b
  end
    
  def move_dirs
    diagonal_dirs + horizontal_dirs + vertical_dirs
  end
end

class King < Piece
  include SteppingPiece
  def initialize(pos=nil, color=nil,board=nil, symbol="\u2654")
    super
    @symbol = "\u265A" if @color == :b
  end
  
  def move_dirs
    every_dir
  end
end

class Rook < Piece
  include SlidingPiece
  def initialize(pos=nil, color=nil,board=nil, symbol="\u2656")
    super
    @symbol = "\u265C" if @color == :b
  end
  
  def move_dirs
    vertical_dirs + horizontal_dirs
  end
end


