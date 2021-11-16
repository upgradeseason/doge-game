#! /usr/bin/env ruby
require 'ruby2d'

set title: 'Doge Game'
set background: '#039be6'
set width: 1920
set height: 1080
set resizable: true
set fps_cap: 15

GRID_SIZE = 10
$positions = [[2, 0], [2, 1], [2, 2], [2, 3]]

#$circle = Circle.new(x: 200, y: 50, radius: 50, sectors: 64, color: 'black', z: 0)
#$image = Image.new('hodl_logo8x8-extra-small.png', x: 200, y: 300, width: 100, height: 100, color: 'white')
$image = Image.new('doge-image-small.png', x: 200, y: 300, width: 100, height: 100, color: 'white')
$coin = Sprite.new('doge-sprite.png', clip_width: 106.8, time: 67, loop: true, x: 300, y: 400, z: 1)

#def draw
#  $positions.each do |position|
#    Circle.new(x: position[0] * GRID_SIZE, y: position[1] * GRID_SIZE, size: 107, color: 'black')
#  end
#end

$x_speed = 0
$y_speed = 0

on :key_down do |event|

  if event.key == 'left'
    $x_speed = -3
    $y_speed = 0
  elsif event.key == 'right'
    $x_speed = 3
    $y_speed = 0
  elsif event.key == 'up'
    $x_speed = 0
    $y_speed = -3
  else event.key == 'down'
    $x_speed = 0
    $y_speed = 3
  end
end

$coin.play
#draw
update do
  $image.x += $x_speed
  $image.y += $y_speed
end

show
