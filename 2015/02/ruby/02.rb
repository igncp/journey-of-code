require_relative "src/common"

input_tuples = Common::get_input_tuples()
total_ribbon = Common::get_total_ribbon(input_tuples)

raise "Invalid solution" unless total_ribbon == 3812909
