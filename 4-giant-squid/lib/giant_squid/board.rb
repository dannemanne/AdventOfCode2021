module GiantSquid
  class Board

    attr_reader :rounds

    def initialize(numbers)
      @numbers = numbers
      @number_positions = parse_board numbers

      @row_counters = Array.new(5).fill(0)
      @col_counters = Array.new(5).fill(0)

      @called = {}
      @bingo_by = nil
      @rounds = 0
    end

    def bingo?
      !@bingo_by.nil?
    end

    def bingo!(by_number)
      @bingo_by = by_number
    end

    def printable
      @numbers.map do |row|
        row.map { |number|
          (@called[number] ? "*" : number).rjust(2, " ")
        }
      end
    end

    def call_number(number)
      return if bingo?

      @rounds += 1

      unless (pos = @number_positions[number]).nil?
        @row_counters[pos[0]] += 1
        @col_counters[pos[1]] += 1
        @called[number] = true

        bingo!(number) if @row_counters[pos[0]] == 5 || @col_counters[pos[1]] == 5
      end
    end

    def score
      @numbers.reduce(0) do |acc, row|
        row.reduce(acc) { |acc2, number|
          @called[number] ? acc2 : acc2 + number.to_i
        }
      end * @bingo_by.to_i
    end

    private

    def parse_board(numbers)
      numbers.each_with_index.each_with_object({}) do |(row, i), acc|
        row.each_with_index do |number, j|
          acc[number] = [i, j]
        end
      end
    end
  end
end
