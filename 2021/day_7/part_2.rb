# frozen_string_literal: true

input = File.open('input.txt').read
input_positions = input.split(',').map(&:to_i)

positions = Array.new(input_positions.max + 1, 0)
input_positions.each { |position| positions[position] += 1 }

result = Float::INFINITY

positions.each_with_index do |_, move_to|
  total_fuel_cost = 0

  positions.each_with_index do |crabs, position|
    fuel_cost = (1..(position - move_to).abs).sum
    total_fuel_cost += fuel_cost * crabs
  end

  result = total_fuel_cost if total_fuel_cost < result
end

puts result
