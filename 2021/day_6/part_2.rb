# frozen_string_literal: true

input = File.open('input.txt').read
states = input.split(',').map(&:to_i)

fishes = { 0 => 0, 1 => 0, 2 => 0, 3 => 0, 4 => 0, 5 => 0, 6 => 0, 7 => 0, 8 => 0 }

states.each { |state| fishes[state] += 1 }

256.times do
  spawn_fish = fishes[0]

  (1..8).each do |index|
    fishes[index - 1] = fishes[index]
  end

  fishes[6] += spawn_fish

  fishes[8] = spawn_fish
end

result = fishes.values.sum
puts result
