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
# This, plus the @apple coordinate pair are the 2 inputs availble for AIs
# Other AI inputs can be calculated from these inputs.

class SnakeGame
  attr_reader :length, :width, :snakes, :score

  EMPTY_CELL = " "
  SNAKE_BODY = "X"
  SNAKE_HEAD = "O"
  APPLE      = "A"

  def initialize(length: 5, width: 5, players: 1)
    @score = 0
    @length = length
    @width = width
    @snakes = []

    # Which snakes turn is it?
    @turn = 0

    players.times do
      initialize_snake
    end

    set_apple
  end

  # Direction:
  #  0: up
  #  1: right
  #  2: down
  #  3: left
  def move(direction)
    snake = @snakes[@turn]

    new_head = snake.first.dup

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
    return false if snake.include?(new_head)

    # TODO: check for eating other snake

    snake.unshift(new_head)

    if snake.first == @apple
      @score += 1
      set_apple
    else
      snake.pop
    end

    if @turn == @snakes.length - 1
      @turn = 0
    else
      @turn += 1
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

    @snakes.each_with_index do |snake, snake_num|
      snake.each_with_index do |snake_segment, index|
        x, y = snake_segment
        if index == 0
          board[x][y] = SNAKE_HEAD
        else
          board[x][y] = snake_num
        end
      end
    end

    board
  end

  # Initialize a new snake. Does some work to avoid placing a new snake on top of an existing one.
  def initialize_snake
    new_snake_coords = [
      rand(0..@length-1),
      rand(0..@width-1)
    ]

    snake_heads = @snakes.map(&:first)

    if snake_heads.include?(new_snake_coords)
      initialize_snake
    else
      @snakes << [new_snake_coords]
    end
  end

  # Sets random apple position
  # Ensures apple does not spawn on snake body.
  def set_apple
    apple = [
      rand(0..(@length - 1)),
      rand(0..(@width - 1))
    ]

    @snakes.each do |snake|
      return set_apple if snake.include? apple
    end

    @apple = apple
  end
end
