module Lanternfish
  class App
    def self.run(input_path, cycles)
      puts "Running app with path: #{input_path}"

      fish_timers = File.read(input_path).strip.split(",")

      school = School.new fish_timers
      cycles.to_i.times do |i|
        school.cycle!
        puts "#{i+1}: #{school.count}"
      end

      puts "\nTotal no. of fish in school: #{school.count}"
    end
  end
end
