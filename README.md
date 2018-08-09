# Chess

A simple terminal based chess game that implements basic OOP concepts in Ruby.

![Alt Text](https://i.imgur.com/75WrbK2.gif)

## Technologies

[Colorize](https://github.com/fazibear/colorize)

## Features

* Simple terminal-based GUI. Shows board, pieces, cursor, and selection

* Move validation

```ruby
  def check_piece(player_color, start_pos, end_pos)
    raise 'The position is empty' if empty?(start_pos)

    piece = self[start_pos]

    if piece.color != player_color
      raise 'That is not your piece.'
    elsif !piece.moves.include?(end_pos)
      raise 'Piece cannot move like that'
    elsif !piece.valid_moves.include?(end_pos)
      raise 'You cannot move into check'
    end

    #actual movement of piece
    move_piece!(start_pos, end_pos)
  end
```

* Detects checks and checkmates

```ruby
  def in_check?(color)
    position = find_king(color).pos
    pieces.any? do |piece|
      piece.color != color && piece.moves.include?(position)
    end
  end
```

```ruby
  def checkmate?(color)
    return false unless self.in_check?(color)
    self.pieces.select { |piece| piece.color == color }.all? { |piece| piece.valid_moves.empty? }
  end
```

* Detects attacks

```ruby
  def moves
    x, y = pos
    moves = []

    move_diffs.each do |plot|
      next_pos = [x + plot.first, y + plot.last]
      next unless board.valid_pos?(next_pos)
      if board.empty?(next_pos) || board[next_pos].color != color
        moves.push(next_pos)
      end
    end
    moves
  end
```

* Implements Singleton module to populate blank positions
```ruby
require 'singleton'

class NullPiece < Piece
  attr_reader :symbol

  include Singleton

  def initialize
    @symbol = ' '
    @color = :none
  end

  def moves
    []
  end

  def symbol
    @symbol = nil
  end

end

```
## Future Development
* Castling
* Draws
* Pawn promotion
* AI
