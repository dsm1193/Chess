require_relative 'board'
require_relative 'display'
require_relative 'player'
require 'byebug'

class Game

    attr_reader :board, :display, :current_player, :players

    def initialize#(player1,player2)
      @board = Board.new
      @display = Display.new(@board)
      @players = {
        w: Player.new(:w, @display),
        b: Player.new(:b, @display)
      }
      @current_player = :w
    end

    def switch_players!
      @current_player = current_player == :w ? :b : :w
    end

    def play
      until board.checkmate?(current_player)
        begin
          from, to =  players[current_player].make_move(board)
          board.move_piece(current_player, from, to)
          switch_players!
          notify_players
        rescue StandardError => e
          @display.notifications[:error] = e.message
          retry
        end
      end
      debugger
      puts "#{current_player} is checkmated."
      nil
    end


    def notify_players
      if board.in_check?(current_player)
        display.set_check
      else
        display.uncheck
      end
    end

end

a = Game.new
a.play
