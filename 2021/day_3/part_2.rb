# frozen_string_literal: true

class Array
  def get_dominating_bit_at(index)
    ones_count = count { |record| record[index] == '1' }
    zeros_count = count { |record| record[index] == '0' }

    ones_count >= zeros_count ? select { |record| record[index] == '1' } : select { |record| record[index] == '0' }
  end

  def get_not_dominating_bit_at(index)
    ones_count = count { |record| record[index] == '1' }
    zeros_count = count { |record| record[index] == '0' }

    zeros_count <= ones_count ? select { |record| record[index] == '0' } : select { |record| record[index] == '1' }
  end
end

input = File.open('input.txt').read
report = input.split

oxygen_generator_rating = report
(0...oxygen_generator_rating.first.size).each do |index|
  break if oxygen_generator_rating.size == 1

  oxygen_generator_rating = oxygen_generator_rating.get_dominating_bit_at(index)
end

co2_scrubber_rating = report
(0...co2_scrubber_rating.first.size).each do |index|
  break if co2_scrubber_rating.size == 1

  co2_scrubber_rating = co2_scrubber_rating.get_not_dominating_bit_at(index)
end

result = oxygen_generator_rating.first.to_i(2) * co2_scrubber_rating.first.to_i(2)
puts result
