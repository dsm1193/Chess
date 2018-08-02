module SlidingPiece

  def horizontal_dirs
    [[-1, 0], [0, -1], [0, 1], [1, 0]]
  end

  def diagonal_dirs
    [[1,1], [-1,-1], [1,-1], [-1,1]]
  end

  def moves
    moves = []
    move_dirs.each do |x,y|
      moves.concat( grow_unblocked_moves_in_dir(x, y) )
    end
    moves
  end

  def grow_unblocked_moves_in_dir(x, y)
    i, j = pos
    moves_arr = []

    while true
      i, j = i+x, j+y
      new_pos = [i, j]
      break unless board.valid_pos?(new_pos)
      if board.empty?(new_pos)
        moves_arr.push(new_pos)
      else
        moves_arr.push(new_pos) if board[new_pos].color != color
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
