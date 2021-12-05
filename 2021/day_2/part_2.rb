# frozen_string_literal: true

input = File.open('input.txt').read
commands = input.split("\n").map { |line| { command: line.split.first, value: line.split.last.to_i } }

position = { horizontal: 0, vertical: 0, aim: 0 }

commands.each do |command|
  case command[:command]
  when 'forward'
    position[:horizontal] += command[:value]
    position[:vertical] += command[:value] * position[:aim]
  when 'up'
    position[:aim] -= command[:value]
  when 'down'
    position[:aim] += command[:value]
  end
end

result = position[:horizontal] * position[:vertical]
puts result
