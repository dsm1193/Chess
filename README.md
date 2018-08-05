# Chess

A simple terminal based chess game that implements basic OOP concepts in Ruby. 

## Technologies

[Colorize](https://github.com/fazibear/colorize) 

## Features

* Move validation

```ruby
  def move_piece(player_color, start_pos, end_pos)
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

* Shows board, cursor, and selection

## Demos

![Alt Text](https://i.imgur.com/75WrbK2.gif)
