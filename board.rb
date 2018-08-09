require_relative 'pieces'

class Board

  attr_reader :rows, :sentinel

  def initialize(fill_board = true)
    @sentinel = NullPiece.instance
    populate_board(fill_board)
  end

  def [](plot)
    # raise 'invalid pos' unless valid_pos?(plot)
    row, col = plot
    @rows[row][col]
  end

  def []=(plot, mark)
    # raise 'invalid pos' unless valid_pos?(plot)
    row, col = plot
    @rows[row][col] = mark
  end

  def check_piece(turn_color, start_pos, end_pos)
      raise 'start position is empty' if empty?(start_pos)

      piece = self[start_pos]

      if piece.color != turn_color
        raise 'You must move your own piece'
      elsif !piece.moves.include?(end_pos)
        raise 'Piece does not move like that'
      elsif !piece.valid_moves.include?(end_pos)
        raise 'You cannot move into check'
      end

      move_piece!(start_pos, end_pos)
    end

    # move without performing checks
    def move_piece!(start_pos, end_pos)

      piece = self[start_pos]
      raise 'piece cannot move like that' unless piece.moves.include?(end_pos)

      self[end_pos] = piece
      self[start_pos] = sentinel
      piece.pos = end_pos

      nil
    end

  def dup
    new_board = Board.new(false)

    pieces.each do |piece|
      piece.class.new(piece.pos, piece.color, new_board)
    end

    new_board
  end

  def valid_pos?(pos)
    #
    pos.all? { |plot| plot.between?(0, 7) }
  end

  def empty?(pos)
    self[pos].empty?
  end

  def checkmate?(color)
    return false unless in_check?(color)
    pieces.select { |piece| piece.color == color }.all? do |piece|
      piece.valid_moves.empty?
    end
  end

  def in_check?(color)

    king_pos = find_king(color).pos
    pieces.any? do |piece|
      piece.color != color && piece.moves.include?(king_pos)
    end
  end

  def add_piece(piece, pos)
    self[pos] = piece
  end

  def pieces
    @rows.flatten.reject(&:empty?)
  end

  def fill_back_row(color)
    back_pieces = [
      Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook
    ]
    i = color == :w ? 7 : 0
    back_pieces.each_with_index do |piece_class, j|
      piece_class.new([i, j], color, self)
    end
  end

  def fill_pawns_row(color)
    i = color == :w ? 6 : 1
    8.times { |j| Pawn.new([i, j], color, self) }

  end

  def find_king(color)
    king_pos = pieces.find { |p| p.color == color && p.is_a?(King) }
    king_pos || (raise 'king not found?')
  end

  def populate_board(fill_board)
    @rows = Array.new(8) { Array.new(8, sentinel) }
    return unless fill_board

    %i(w b).each do |color|
      fill_back_row(color)
      fill_pawns_row(color)
    end

  end

end
