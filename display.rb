require 'colorize'
require_relative 'cursor'
require_relative 'board'

class Display
  attr_reader :cursor

  def initialize(board)
    @board = board
    @cursor = Cursor.new([0,0], @board)
  end

  def render
    system('clear')
    current_cursor_pos = @cursor.cursor_pos

    @board.rows.each.with_index do |row,idx|
      row.each.with_index do |square,idx2|
        if current_cursor_pos == [idx,idx2]
          if square.class == NullPiece && @cursor.selected == true
            print "[ ]".center(3).colorize(:red)
          elsif square.class == NullPiece
            print "[ ]".center(3).colorize(:blue)
          else
            if @cursor.selected == true
              print  "[#{square.symbol.encode('utf-8')}]".center(3).colorize(:red)
            else
              print "[#{square.symbol.encode('utf-8')}]".center(3).colorize(:blue)
            end
          end
        elsif square.class == NullPiece
          print " ".center(3)
        else
          print  "#{square.symbol.encode('utf-8')}".center(3)
        end
      end
      print "\n"
    end
    return
  end

  def change_cursor
    @cursor.get_input
  end

end
