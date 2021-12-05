# frozen_string_literal: true

input = File.open('input.txt').read
measurements = input.split.map(&:to_i)

result = 0

measurements.drop(3).each_with_index do |_, index|
  group1 = measurements[index..index + 2].sum
  group2 = measurements[index + 1..index + 3].sum

  result += 1 if group2 > group1
end

puts result
