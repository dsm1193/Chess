require_relative 'piece'
require_relative 'display'

class Board

  attr_reader :rows

  def initialize
    @sentinel = NullPiece.instance
    @rows = Array.new(8) { Array.new(8, @sentinel) }
    populate_board
  end

  def [](plot)
    row, col = plot
    @rows[row][col]
  end

  def []=(plot, mark)
    row, col = plot
    @rows[row][col] = mark
  end

  def move_piece(start_pos, end_pos)
    raise StandardError if self[start_pos] == @sentinel ||
      self[end_pos] != @sentinel
    self[end_pos] = self[start_pos]
    self[start_pos] = @sentinel
  end

  def valid_pos?(pos)
    pos.all? {|plot| plot.between?(0,7)}
  end

  # def in_check?
  #   @current_player.color
  #   @board.grid.each do |row|
  #     row.each do |square|
  #       if square.class == King && square.color == @current_player.color
  #
  #       end
  #     end
  #   end
  # end

  # def board_check(pos, color)
  #   @board.grid.each do |row|
  #     row.each do |square|
  #       if square.class != NullPiece && square.color == color
  #
  #       end
  #     end
  #   end
  # end

  private

  def populate_board
    @rows.each_with_index do |row, i|
      row.each_with_index do |col, j|
        if i < 2
          if [i, j] == [0, 2]  || [i, j] == [0, 5]
            self[[i, j]] = Bishop.new([i,j], :b)
          elsif
            [i, j] == [0, 0]  || [i, j] == [0, 7]
            self[[i, j]] = Rook.new([i,j], :b)
          elsif
            [i, j] == [0, 1]  || [i, j] == [0, 6]
            self[[i, j]] = Knight.new([i,j], :b)
          elsif
            [i, j] == [0, 3]
            self[[i, j]] = King.new([i,j], :b)
          elsif
            [i, j] == [0, 4]
            self[[i, j]] = Queen.new([i,j], :b)
          else
            self[[i, j]] = Pawn.new([i,j], :b)
          end
        elsif i > 5
          if [i, j] == [7, 2]  || [i, j] == [7, 5]
            self[[i, j]] = Bishop.new([i,j], :w)
          elsif
            [i, j] == [7, 0]  || [i, j] == [7, 7]
            self[[i, j]] = Rook.new([i,j], :w)
          elsif
            [i, j] == [7, 1]  || [i, j] == [7, 6]
            self[[i, j]] = Knight.new([i,j], :w)
          elsif
            [i, j] == [7, 3]
            self[[i, j]] = King.new([i,j], :w)
          elsif
            [i, j] == [7, 4]
            self[[i, j]] = Queen.new([i,j], :w)
          else
            self[[i, j]] = Pawn.new([i,j], :w)
          end
        end
      end
    end
  end

end
