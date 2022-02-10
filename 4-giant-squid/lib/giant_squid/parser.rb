module GiantSquid
  class Parser
    def initialize(number_board_string)
      @string = number_board_string
    end

    def parse
      @string.split("\n").map { |row| row.strip.split(/\s+/) }
    end
  end
end
