# frozen_string_literal: true

class Array
  def horizontal?
    first.last == last.last
  end

  def vertical?
    first.first == last.first
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
end

input = File.open('input.txt').read
coordinates = input.split("\n").map { |line| line.split('->').map { |point| point.split(',').map(&:to_i) } }

map = Map.new(1000)

coordinates = coordinates.select do |coordinate|
  coordinate.first.first == coordinate.last.first || coordinate.first.last == coordinate.last.last
end
coordinates.each { |coordinate| map.mark(coordinate.first, coordinate.last) }

result = map.data.sum { |row| row.count { |cell| cell >= 2 } }
puts result
