module SlidingPiece
  def moves
    x,y = @pos
    grow_unblocked_moves_in_dir(x, y)
  end

  def move_dir
    vertical_dirs + horizontal_dirs + diagonal_dirs
  end

  def grow_unblocked_moves_in_dir(x, y)

    diff = move_dir
    moves_arr = []

    one, two = x, y

    diff.each do |difference|
      until (x + difference[0] == -1) || (x + difference[0] == 8) || (y + difference[1] == -1) || (y + difference[1] == 8)
        x,y = x+difference.first, y+difference.last
        break if @board[x,y].color == self.color
        moves_arr << [x,y]
      end
      x,y = one, two
    end
    moves_arr
  end

  MOVES = {
    left: [0, -1],
    right: [0, 1],
    up: [-1, 0],
    down: [1, 0],
    ur: [-1, 1],
    dr: [1, 1],
    ul: [-1, -1],
    dl: [1, -1]
  }

  def horizontal_dirs
    return [MOVES[:left], MOVES[:right]]
  end

  def diagonal_dirs
    return [MOVES[:ur], MOVES[:dr], MOVES[:ul], MOVES[:dl]]
  end

  def vertical_dirs
    return [MOVES[:up], MOVES[:down]]
  end

end

module SteppingPiece

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

end
