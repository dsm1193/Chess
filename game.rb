require_relative 'board'
require_relative 'display'
require_relative 'player'
require 'byebug'

class Game

    attr_reader :display, :board, :players, :current_player

    def initialize#(player1,player2)
      @board = Board.new
      @display = Display.new(@board)
      @players = {
        white: Player.new(:w, @display),
        black: Player.new(:b, @display)
      }
      @current_player = @players[:black]
    end

    def switch_players!
      current_player == players[:white] ? current_player = players[:black] : current_player = players[:white]
    end

    def play_turn
    while true
      begin
        from, to = current_player.make_move(board)
        debugger
        board.move_piece(current_player.color, from, to)
        switch_players!
      rescue
        puts 'invalid!!!'
        retry
      end
    end


      # while true
      #   system('clear')
      #   puts 'Please select a piece'
      #
      #   @display.change_cursor
      #
      #   first_pos = nil
      #   end_pos = nil
      #   moves = nil
      #
      #   while @display.cursor.selected == true
      #     first_pos = @display.cursor.cursor_pos
      #     moves = move_finder(first_pos)
      #     @display.change_cursor
      #     puts 'Where you you like to move that piece?'
      #   end
      #
      #   end_pos = @display.cursor.cursor_pos
      #
      #   unless moves.nil?
      #     if moves.include?(end_pos)
      #       @board.move_piece(first_pos, end_pos)
      #     else
      #       raise "invalid move!"
      #     end
      #   end
      #
      # end

    end

    def move_finder(pos)
      system('clear')
      moves = @board[pos].moves
    end

    def play

    end

end

a = Game.new
a.play_turn
