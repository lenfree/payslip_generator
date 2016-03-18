require 'smarter_csv'
require 'pry'
require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/spec'
require_relative './../payslip'
Minitest::Reporters.use!(Minitest::Reporters::SpecReporter.new)

describe 'Payslip' do
  before do
    csv = SmarterCSV.process('input.csv')
    @entry = Payslip::Generate.new(user: csv.first)
  end

  describe 'calculate' do
    it 'should return March' do
      assert_equal("01 March - 31 March", @entry.get_month)
    end

    it 'should return 5004' do
      assert_equal(5004, @entry.gross_income)
    end
  end
end
