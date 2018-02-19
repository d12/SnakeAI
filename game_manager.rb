# GameManager handles initializing games, printing debugging information, and yielding to
# the player classes
require_relative "snake_game"

class GameManager
  def initialize(player_class, length, width)
    @player_class = player_class
    @snake_game = SnakeGame.new(length: 5, width: 5)
  end

  def play
    puts "Playing Snake with player type: #{@player_class.to_s}"

    while true
      move = @player_class.next_move(@snake_game)

      unless @snake_game.move(move)
        puts "Died! Attempted move: #{move}"
        
        puts "Board state:"
        @snake_game.print

        puts "Score: #{@snake_game.score}"

        return @snake_game.score
      end
    end
  end
end
