require_relative './common'

RSpec.describe Common do
  describe 'get_floor_number' do
    expected_values = { '(())': 0, '()()': 0, '(((': 3, '(()(()(': 3, }
    expected_values.each do |val, expected|
      it "returns #{expected} when #{val}" do
        expect(Common::get_floor_number(val.to_s.split(""))).to eq(expected)
      end
    end
  end
end
