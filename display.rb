require 'colorize'
require_relative 'cursor'
require_relative 'board'

class Display
  attr_reader :cursor, :notifications

  def initialize(board)
    @board = board
    @cursor = Cursor.new([0,0], @board)
    @notifications = {}
  end

  def reset_notifications
    @notifications.delete(:error)
  end

  def uncheck
    @notifications.delete(:check)
  end

  def set_check
    @notifications[:check] = "Check!"
  end

  def render
    system('clear')
    puts "Arrow keys, WASD, or vim to move, space or enter to confirm."
    current_cursor_pos = @cursor.cursor_pos
    @board.rows.each.with_index do |row,idx|
      row.each.with_index do |square,idx2|
        if cursor.cursor_pos == [idx,idx2] && @cursor.selected
          print "#{square.symbol}".center(3).colorize( background: :magenta )
        elsif cursor.cursor_pos == [idx,idx2]
          print "#{square.symbol}".center(3).colorize( background: :light_magenta )
        elsif (idx + idx2).odd?
          print "#{square.symbol}".center(3).colorize( background: :light_white )
        else
          print "#{square.symbol}".center(3).colorize( background: :light_black )
        end
      end
      print "\n"
    end
    @notifications.each { |_, val| puts val }
    
  end

  def change_cursor
    @cursor.get_input
  end

end
