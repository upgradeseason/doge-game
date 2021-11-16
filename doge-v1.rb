#! /usr/bin/env ruby
require 'ruby2d'

set title: 'Doge Snake Game'
set background: '#039be6'
set width: 1920
set height: 1080
set resizable: true
set fps_cap: 15

CIRCLE_SIZE = 90
GRID_WIDTH = Window.width / CIRCLE_SIZE
GRID_HEIGHT = Window.height / CIRCLE_SIZE

class Snake
  attr_writer :direction

  def initialize
    @positions = [[2, 0], [2, 1], [2, 2], [2, 3], [2, 4], [2, 5], [2, 6]]
    @direction = 'down'
    @growing = false
  end

  def draw
    @positions.each do |position|
      #Circle.new(x: position[0] * GRID_SIZE, y: position[1] * GRID_SIZE, size: GRID_SIZE, color: 'black')
      Image.new('doge-image-small.png', x: position[0] * CIRCLE_SIZE, y: position[1] * CIRCLE_SIZE, width:
CIRCLE_SIZE, height: CIRCLE_SIZE)
    end
  end

  def grow
    @growing = true
  end

  def move
    if !@growing
      @positions.shift
    end

    @positions.push(next_position)
    @growing = false
  end

  def can_change_direction_to?(new_direction)
    case @direction
    when 'up' then new_direction != 'down'
    when 'down' then new_direction != 'up'
    when 'left' then new_direction != 'right'
    when 'right' then new_direction != 'left'
    end
  end

  def x
    head[0]
  end

  def y
    head[1]
  end

  def next_position
    if @direction =='down'
      new_coords(head[0], head[1] + 1)
    elsif @direction == 'up'
      new_coords(head[0], head[1] -1)
    elsif @direction == 'left'
      new_coords(head[0] - 1, head[1])
    elsif @direction == 'right'
      new_coords(head[0] + 1, head[1])
    end
  end

  def new_coords(x, y)
    [x % GRID_WIDTH, y % GRID_HEIGHT]
  end

  def head
    @positions.last
  end

  def hit_itself?
    @positions.uniq.length != @positions.length
  end
end

class Game
  def initialize
    @score = 0
    @coin_x = rand(GRID_WIDTH)
    @coin_y = rand(GRID_HEIGHT)
    @finished = false
    #$sprite = Sprite.new(
    #  'doge-sprite.png',
    #  clip_width: 106.8,
    #  time: 47,
    #  x: @coin_x,
    #  y: @coin_y)
  end

  def draw
    #$sprite.play
    #$coin = Sprite.new('doge-sprite.png', clip_width: 106.8, time: 67, loop: true, x: 300, y: 400, z: 1)
    Image.new('doge-coin.png', x: @coin_x * CIRCLE_SIZE, y: @coin_y * CIRCLE_SIZE, width: CIRCLE_SIZE, height: CIRCLE_SIZE)
    Text.new(text_message, font: 'Lato-Black.ttf', color: 'black', x: 50, y: 50, size: 34)
  end

  def snake_hit_coin?(x, y)
    @coin_x == x && @coin_y == y
  end

  def record_hit
    @score += 1
    @coin_x = rand(GRID_WIDTH)
    @coin_y = rand(GRID_HEIGHT)
  end

  def finish
    @finished = true
  end

  def finished?
    @finished
  end

  def text_message
    if finished?
      "Great, you've earned #{@score} Doge points! Press 'd' to play again!"
    else
      "Doge points: #{@score}"
    end
  end
end

snake = Snake.new
game = Game.new

update do
  clear

  unless game.finished?
    snake.move
  end

  snake.draw
  game.draw

  if game.snake_hit_coin?(snake.x, snake.y)
    game.record_hit
    snake.grow
  end

  if snake.hit_itself?
    game.finish
  end
end

on :key_down do |event|
  if ['up', 'down', 'left', 'right'].include?(event.key)
    if snake.can_change_direction_to?(event.key)
    snake.direction = event.key
    end
  end

  if game.finished? && event.key == 'd'
    snake = Snake.new
    game = Game.new
  end
end

show
