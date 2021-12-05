# frozen_string_literal: true

class Board
  def initialize(data)
    @data = data.map { |row| row.split.map { |value| { value: value.to_i, marked: false } } }
  end

  def wins?
    row_wins? || column_wins?
  end

  def row_wins?
    (0...@data.size).any? { |row_index| row(row_index).all? { |cell| cell[:marked] } }
  end

  def column_wins?
    (0...@data.size).any? { |column_index| column(column_index).all? { |cell| cell[:marked] } }
  end

  def row(index)
    @data[index]
  end

  def column(index)
    @data.map { |row| row[index] }
  end

  def mark(value)
    cell = @data.flatten.select { |data| data[:value] == value }
    return if cell.size.zero?

    cell.first[:marked] = true
  end

  def unmarked
    @data.flatten.reject { |data| data[:marked] }
  end
end

input = File.open('input.txt').read
lines = input.split("\n").select { |line| line.size.positive? }

drawn_numbers = lines.shift.split(',').map(&:to_i)
boards = lines.each_slice(5).to_a.map { |board_data| Board.new(board_data) }

result = nil

drawn_numbers.each do |drawn_number|
  boards.each { |board| board.mark(drawn_number) }

  next unless boards.any?(&:wins?)

  win_board = boards.select(&:wins?).first
  result = win_board.unmarked.sum { |data| data[:value] } * drawn_number
  break
end

puts result
