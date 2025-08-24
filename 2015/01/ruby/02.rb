# frozen_string_literal: true

require_relative 'common'

input_chars = Common.get_input_chars
floor_position = Common.get_position_of_floor(-1, input_chars)

raise("Invalid solution #{floor_position}") unless floor_position == 1771
