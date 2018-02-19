# Represents a game of Snake
#
# The snake object is a array of [x,y] pairs represnting the snake segments
# The first segment is the head of the snake
#
# E.g.
# snake = [
#   [1, 2]
#   [2, 2]
#   [3. 2]
# ]
#
# This, plus the @snake coordinate pair are the 2 inputs availble for AIs
# Other AI inputs can be calculated from these inputs.

class SnakeGame
  attr_reader :length, :width, :snake, :score

  EMPTY_CELL = " "
  SNAKE_BODY = "X"
  SNAKE_HEAD = "O"
  APPLE      = "A"

  def initialize(length: 5, width: 5)
    @score = 0
    @length = length
    @width = width

    # Center the snake initially
    initialize_snake
    set_apple
  end

  # Direction:
  #  0: up
  #  1: right
  #  2: down
  #  3: left
  def move(direction)
    new_head = @snake.first.dup

    case direction
    when 0
      new_head[0] -= 1
    when 1
      new_head[1] += 1
    when 2
      new_head[0] += 1
    when 3
      new_head[1] -= 1
    end

    # Wall check
    return false unless new_head[0] < @length &&
      new_head[1] < @width &&
      new_head[0] >= 0 &&
      new_head[1] >= 0

    # Eating yourself check
    return false if @snake.include?(new_head)

    @snake.unshift(new_head)

    if snake.first == @apple
      @score += 1
      set_apple
    else
      @snake.pop
    end

    true
  end

  def print
    board = create_board

    puts "* " *(@length + 1)

    board.each do |row|
      puts "*#{row.join(" ")}*"
    end

    puts "* " * (@length + 1)
  end

  private

  # Sets up a length * width 2d array used to pretty print the board state
  def create_board
    board = Array.new(@length) { Array.new(@width, EMPTY_CELL) }

    board[@apple[0]][@apple[1]] = APPLE

    @snake.each_with_index do |snake_segment, index|
      x, y = snake_segment
      if index == 0
        board[x][y] = SNAKE_HEAD
      else
        board[x][y] = SNAKE_BODY
      end
    end

    board
  end

  def initialize_snake
    @snake = [[
      @length / 2,
      @width / 2
    ]]
  end

  # Sets random apple position
  # Ensures apple does not spawn on snake body.
  def set_apple
    while true
      @apple = [
        rand(0..(@length - 1)),
        rand(0..(@width - 1))
      ]

      break unless @snake.include? @apple
    end
  end
end
