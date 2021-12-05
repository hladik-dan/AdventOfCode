# frozen_string_literal: true

input = File.open('input.txt').read
measurements = input.split.map(&:to_i)

result = 0

measurements.drop(1).each_with_index do |measurement, index|
  previous_measurement = measurements[index]

  result += 1 if measurement > previous_measurement
end

puts result
