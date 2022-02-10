module GiantSquid
  class App
    def self.run(input_path)
      # Parse input
      number_boards, bingo_numbers = parse_input input_path

      # Build boards
      boards = number_boards.map { |number_board|
        Board.new(number_board)
      }

      # Call numbers
      bingo_numbers.each do |number|
        boards.each_with_index do |board, i|
          board.call_number number
        end
      end

      # Print result
      winning_board, *_, losing_board = boards.sort_by(&:rounds)

      puts "\nWinning Score: #{winning_board.score}, by round: #{winning_board.rounds}"
      winning_board.printable.each { |row| puts row.join(" ") }

      puts "\nLosing Score: #{losing_board.score}, by round: #{losing_board.rounds}"
      losing_board.printable.each { |row| puts row.join(" ") }
    end

    def self.parse_input(input_path)
      bingo_number_string, *number_board_strings = File.read(input_path).split("\n\n")

      number_boards = number_board_strings.map { |number_board_string|
        Parser.new(number_board_string).parse
      }

      bingo_numbers = bingo_number_string.split(",")

      [number_boards, bingo_numbers]
    end
  end
end
