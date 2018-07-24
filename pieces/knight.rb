require_relative 'piece'

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
