require_relative './common'

RSpec.describe Common do
  describe 'parse_line' do
    expected_values = { '1x2x3': [1, 2, 3], '4x1x2': [1, 2, 4] }
    expected_values.each do |val, expected|
      it "returns #{expected} when #{val}" do
        # Call a private method using class_eval in the test
        expect(Common::class_eval { parse_line(val) }).to eq(expected)
      end
    end
  end

  describe 'get_total_area' do
    expected_values = { '58': [[2, 3, 4]], '43': [[1, 1, 10]] }
    expected_values.each do |total, tuple|
      it "returns #{total} when #{tuple}" do
        expect(Common::get_total_area(tuple)).to eq(total.to_s.to_i)
      end
    end
  end

  describe 'get_total_ribbon' do
    expected_values = { '34': [[2, 3, 4]], '14': [[1, 1, 10]] }
    expected_values.each do |total, tuple|
      it "returns #{total} when #{tuple}" do
        expect(Common::get_total_ribbon(tuple)).to eq(total.to_s.to_i)
      end
    end
  end
end
