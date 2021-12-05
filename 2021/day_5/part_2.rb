# frozen_string_literal: true

class Array
  def horizontal?
    first.last == last.last
  end

  def vertical?
    first.first == last.first
  end

  def bottom_left?
    first.first > last.first && first.last < last.last
  end

  def bottom_right?
    first.first < last.first && first.last < last.last
  end

  def top_left?
    first.first > last.first && first.last > last.last
  end

  def top_right?
    first.first < last.first && first.last > last.last
  end
end

class Map
  attr_reader :data

  def initialize(size)
    @size = size
    @data = Array.new(size) { Array.new(size, 0) }
  end

  def mark(point1, point2)
    mark_horizontal(point1, point2) if [point1, point2].horizontal?
    mark_vertical(point1, point2) if [point1, point2].vertical?
    mark_bottom_left(point1, point2) if [point1, point2].bottom_left?
    mark_bottom_right(point1, point2) if [point1, point2].bottom_right?
    mark_top_left(point1, point2) if [point1, point2].top_left?
    mark_top_right(point1, point2) if [point1, point2].top_right?
  end

  def mark_horizontal(point1, point2)
    x_point = [point1.first, point2.first].sort
    y = point1.last

    (x_point.first..x_point.last).each { |x| @data[y][x] += 1 }
  end

  def mark_vertical(point1, point2)
    x = point1.first
    y_point = [point1.last, point2.last].sort

    (y_point.first..y_point.last).each { |y| @data[y][x] += 1 }
  end

  def mark_bottom_left(point1, point2)
    size = (point1.first - point2.first).abs
    x = point1.first
    y = point1.last

    (0..size).each { |offset| @data[y + offset][x - offset] += 1 }
  end

  def mark_bottom_right(point1, point2)
    size = (point1.first - point2.first).abs
    x = point1.first
    y = point1.last

    (0..size).each { |offset| @data[y + offset][x + offset] += 1 }
  end

  def mark_top_left(point1, point2)
    size = (point1.first - point2.first).abs
    x = point1.first
    y = point1.last

    (0..size).each { |offset| @data[y - offset][x - offset] += 1 }
  end

  def mark_top_right(point1, point2)
    size = (point1.first - point2.first).abs
    x = point1.first
    y = point1.last

    (0..size).each { |offset| @data[y - offset][x + offset] += 1 }
  end
end

input = File.open('input.txt').read
coordinates = input.split("\n").map { |line| line.split('->').map { |point| point.split(',').map(&:to_i) } }

map = Map.new(1000)

coordinates.each { |coordinate| map.mark(coordinate.first, coordinate.last) }

result = map.data.sum { |row| row.count { |cell| cell >= 2 } }
puts result
