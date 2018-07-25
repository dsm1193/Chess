module SlidingPiece

  def horizontal_dirs
    [[-1, 0], [0, -1], [0, 1], [1, 0]]
  end

  def diagonal_dirs
    [[1,1], [-1,-1], [1,-1], [-1,1]]
  end

  def moves
    moves = []
    move_dirs.each do |plot|
      moves.concat( grow_unblocked_moves_in_dir(plot.first, plot.last) )
    end
    moves
  end

  def grow_unblocked_moves_in_dir(x, y)
    i, j = pos
    moves_arr = []
    while true
      new_pos = [i+x, j+y]

      break unless board.valid_pos?(new_pos)
      if board.empty?(new_pos)
        moves_arr.push(new_pos)
        x += 1 if x > 0
        y += 1 if y > 0
        x -= 1 if x < 0
        y -= 1 if y < 0
      else
        moves_arr.push(new_pos) if board[pos].color != color
        break
      end
    end
    moves_arr
  end

  def move_dirs
    # subclass implements this
    raise NotImplementedError
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
