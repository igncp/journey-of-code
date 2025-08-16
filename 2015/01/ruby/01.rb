require_relative "common"

input_chars = Common::get_input_chars()
current_floor = Common::get_floor_number(input_chars)

raise "Invalid solution" unless current_floor == 138
