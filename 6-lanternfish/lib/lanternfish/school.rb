module Lanternfish
  class School
    def initialize(fish_timers)
      grouped_timers = fish_timers.group_by(&:to_i)
      @groups_in_sequence = 9.times.map { |i| Array(grouped_timers[i]).length }
    end

    def cycle!
      first, *rest = @groups_in_sequence
      @groups_in_sequence = [*rest, first]
      @groups_in_sequence[6] += first
    end

    def count
      @groups_in_sequence.sum
    end
  end
end
