# frozen_string_literal: false

input = File.open('input.txt').read
report = input.split

bit_count = Array.new(report.first.size) { { ones: 0, zeros: 0 } }

report.each do |record|
  record.chars.each_with_index do |binary_number, index|
    bit_count[index][:ones] += 1 if binary_number == '1'
    bit_count[index][:zeros] += 1 if binary_number == '0'
  end
end

gamma_rate = ''
epsilon_rate = ''

bit_count.each_with_index do |_, index|
  gamma_rate << (bit_count[index][:ones] > bit_count[index][:zeros] ? '1' : '0')
  epsilon_rate << (bit_count[index][:ones] > bit_count[index][:zeros] ? '0' : '1')
end

result = gamma_rate.to_i(2) * epsilon_rate.to_i(2)
puts result
