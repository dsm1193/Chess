require_relative 'board'
require_relative 'display'
require_relative 'player'
require 'byebug'

class Game

    attr_reader :display, :board, :players
    attr_accessor :current_player

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
      if @current_player == @players[:white]
        @current_player = @players[:black]
      else
        @current_player = @players[:white]
      end
    end

    def play_turn
      # while true
      until board.checkmate?(current_player.color)
        begin
          from, to = current_player.make_move(board)
          board.move_piece(current_player.color, from, to)
          switch_players!
        rescue StandardError => e
          @display.notifications[:error] = e.message
          retry
        end
      end

      puts "#{current_player} is checkmated."

      nil
    end

    def move_finder(pos)
      moves = @board[pos].moves
    end

end

a = Game.new
a.play_turn
