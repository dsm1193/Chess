require_relative 'board'
require_relative 'display'
require 'byebug'

class Game

    attr_reader :display, :board

    def initialize#(player1,player2)
      @board = Board.new
      @display = Display.new(@board)
      #@player1 = player1
      #@player2 = player2
      #@current_player = @player1
    end

    def switch_players!
      @current_player == @player1 ? @current_player = @player2 : @current_player = @player1
    end

    def play_turn

      while true
        system('clear')
        puts 'Please select a piece'
        @display.change_cursor
        first_pos = nil
        moves = nil
        while @display.cursor.selected == true
          first_pos = @display.cursor.cursor_pos
          moves = move_finder(first_pos)
          debugger
          @display.change_cursor
          puts 'Where you you like to move that piece?'
        end

        print first_pos

        print moves

      end_pos = @display.cursor.cursor_pos
        unless moves.nil?
          if moves.include?(end_pos)
            @board.move_piece(first_pos, end_pos)
          else
            raise "invalid move!"
          end
        end

      end

    end

    def move_finder(pos)
      system('clear')
      puts 'i was never here'
      puts @board[pos].class
      moves = @board[pos].moves
      p moves
    end

    def play

    end

end

a = Game.new
a.play_turn
