module Common
  def self.get_input_chars()
    input_file = File.open("../input_1.txt", "r")
    input_chars = input_file.read.split("")
    input_file.close

    return input_chars
  end

  def self.get_floor_number(input_chars)
    current_floor, _ = traverse_floors(input_chars)
    current_floor
  end

  def self.get_position_of_floor(target_floor, input_chars)
    position = 0
    traverse_floors(input_chars) do |current_floor, pos|
      if current_floor == target_floor
        position = pos
        break
      end
    end

    position
  end

  private

  def self.traverse_floors(input_chars)
    current_floor = 0
    position = 0

    input_chars.each do |char|
      if char == "("
        current_floor += 1
      elsif char == ")"
        current_floor -= 1
      end
      position += 1

      yield(current_floor, position) if block_given?
    end

    return current_floor, position
  end
end
