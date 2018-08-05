# Chess

A simple terminal based chess game that implements basic OOP concepts in Ruby. 

## Technologies

[Colorize](https://github.com/fazibear/colorize) 

## Features

* Move validation

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

* Shows board, cursor, and selection

## Demos

![Alt Text](https://i.imgur.com/75WrbK2.gif)
