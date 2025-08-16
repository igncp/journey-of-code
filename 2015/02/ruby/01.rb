require_relative "src/common"

input_tuples = Common::get_input_tuples()
total_area = Common::get_total_area(input_tuples)

raise "Invalid solution" unless total_area == 1598415
