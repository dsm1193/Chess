require_relative 'pieces'
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

  def move_piece(color, start_pos, end_pos)

    raise 'start position is empty' if empty?(start_pos)

    if self[start_pos].color != color

      raise 'You can only move your own piece.'
    elsif !self[start_pos].moves.include?(end_pos)

      raise 'Invalid move.'
    # elsif !self[start_pos].valid_moves.include?(end_pos)
    #   raise 'You cannot move into check'
    end

    self[end_pos] = self[start_pos]
    self[end_pos].pos = end_pos
    self[start_pos] = @sentinel
    self[start_pos].pos = start_pos
    nil
  end

  def valid_pos?(pos)
    pos.all? { |plot| plot.between?(0,7) }
  end

  def empty?(pos)
    self[pos].empty?
  end

  private

  def pieces
    @rows.flatten.reject(&:empty?)
  end

  def populate_board
    @rows.each_with_index do |row, i|
      row.each_with_index do |col, j|
        if i < 2
          if [i, j] == [0, 2]  || [i, j] == [0, 5]
            self[[i, j]] = Bishop.new([i,j], :b, self)
          elsif
            [i, j] == [0, 0]  || [i, j] == [0, 7]
            self[[i, j]] = Rook.new([i,j], :b, self)
          elsif
            [i, j] == [0, 1]  || [i, j] == [0, 6]
            self[[i, j]] = Knight.new([i,j], :b, self)
          elsif
            [i, j] == [0, 3]
            self[[i, j]] = King.new([i,j], :b, self)
          elsif
            [i, j] == [0, 4]
            self[[i, j]] = Queen.new([i,j], :b, self)
          else
            self[[i, j]] = Pawn.new([i,j], :b, self)
          end
        elsif i > 5
          if [i, j] == [7, 2]  || [i, j] == [7, 5]
            self[[i, j]] = Bishop.new([i,j], :w, self)
          elsif
            [i, j] == [7, 0]  || [i, j] == [7, 7]
            self[[i, j]] = Rook.new([i,j], :w, self)
          elsif
            [i, j] == [7, 1]  || [i, j] == [7, 6]
            self[[i, j]] = Knight.new([i,j], :w, self)
          elsif
            [i, j] == [7, 3]
            self[[i, j]] = King.new([i,j], :w, self)
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

  # def find_king(color)
  #   pieces.find { |piece| piece.color == color && piece.is_a?(King) }
  # end
  #
  #
  # def in_check?(color)
  #   king_pos = find_king(color).pos
  #   pieces.any? do |piece|
  #     piece.color != color && piece.moves.include?(king_pos)
  #   end
  # end
  #
  #
  # def checkmate?(color)
  #   return false unless in_check?(color)
  #   pieces.select { |p| p.color == color }.all? do |piece|
  #     piece.valid_moves.empty?
  #   end
  # end
