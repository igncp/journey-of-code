module Common
  def self.get_input_tuples()
    input_file = File.open("../input.txt", "r")
    input_lines = input_file.read.split("\n")
    input_file.close

    return input_lines.map do |line|
      parse_line(line)
    end
  end

  def self.get_total_area(input_tuples)
    return input_tuples.reduce(0) do |total_area, dimensions|
      l, w, h = dimensions
      side_areas = [l * w, w * h, h * l]
      total_area + 2 * side_areas.sum + side_areas.min
    end
  end

  def self.get_total_ribbon(input_tuples)
    return input_tuples.reduce(0) do |total_ribbon, dimensions|
      a, b, c = dimensions
      perimeter = 2 * (a + b)
      volume = a * b * c
      total_ribbon + perimeter + volume
    end
  end

  private

  def self.parse_line(line)
    line.to_s.split("x").map(&:to_i).sort()
  end
end
