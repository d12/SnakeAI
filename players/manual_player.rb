# A snake player which defers control to a human via console commands
class ManualPlayer
  def next_move(snake_game)
    puts "Current board: "
    snake_game.print

    puts "What is your next move? (n,s,e,w):"

    move = gets.chomp

    case move
    when "n"
      0
    when "s"
      2
    when "e"
      1
    when "w"
      3
    else
      puts "Invalid move. What is your next move? (n,s,e,w):"
      next_move(snake_game)
    end
  end
end
