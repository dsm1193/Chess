require 'byebug'
require_relative 'board'
require_relative 'display'


class Game

    def initialize#(player1,player2)
      @board = Board.new
      #@player1 = player1
      #@player2 = player2
      #@current_player = @player1
      @display = Display.new(@board)
    end
    
    def switch_players!
      @current_player == @player1 ? @current_player = @player2 : @current_player = @player1
    end 
    
    def play_turn
      
      while true
        #system('clear')
        puts 'Please select a piece'
        @display.change_cursor
        first_pos = nil
        moves = nil
        while @display.cursor.selected == true
          first_pos = @display.cursor.cursor_pos
          moves = move_finder(first_pos)
          @display.change_cursor
          puts 'Where you you like to move that piece?'
        end
        ####
        print first_pos
        ####
        print moves
        ####
        move_to_here = @display.cursor.cursor_pos
        unless moves == nil
          if moves.include?(move_to_here)
            @board.move_piece(first_pos,move_to_here)
          else
            raise "invalid move!"
          end
        end
        
      end
      
    end
    
    def move_finder(pos)
      puts 'i was never here'
      puts @board[pos].class
      moves = @board[pos].moves
      p moves
    end
    
    def play

    end
    
end