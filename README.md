# Snake AI

A simple command line snake game where the snake is controlled by an interchangable AI module.

To use, create a new player in `players/`. Player classes should implement `#next_move` which takes the game state as input and outputs the next move. To test your player, swap `ManualPlayer` for your new player in `main.rb` and run `ruby main.rb`.

An example of a simple player can be seen in [players/manual_player.rb](https://github.com/d12/SnakeAI/blob/master/players/manual_player.rb)

## SnakeGame 

`SnakeGame` is the game state object passes into player objects. It exposes two pieces of information

### @apple

`@apple` represents the 2d coordinate of the apple. 

```
@apple
=> [1, 2]
```

### @snake

`@snake` represents the position of all segments of the snake. The first segment is the head of the snake.

```
@snake
= > [[1, 3], [1, 4], [2, 4]]
```
