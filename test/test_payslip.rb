require 'csv'
require 'pry'
require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/spec'
require_relative './../payslip'
Minitest::Reporters.use!(Minitest::Reporters::SpecReporter.new)

describe 'Payslip' do
  before do
    csv = CSV.read('input.csv', headers: true).map{ |row| row.to_hash }
    @entry = Payslip::Generate.new(user: csv.first)
    @high_income = Payslip::Generate.new(user: csv.last)
  end

  describe 'calculate' do
    it 'should return March' do
      assert_equal("01 March - 31 March", @entry.get_month)
    end

    it 'should return 5004' do
      assert_equal(5_004, @entry.gross_income)
    end

    it 'should return 16,667' do
      assert_equal(16_667, @high_income.gross_income)
    end

    it 'should return 922' do
      assert_equal(922, @entry.income_tax)
    end

    it 'should return 5,296' do
      assert_equal(5_296, @high_income.income_tax)
    end

    it 'should return 4082' do
      assert_equal(4082, @entry.net_income)
    end

    it 'should return 11371' do
      assert_equal(11371, @high_income.net_income)
    end

    it 'should return 450' do
      assert_equal(450, @entry.super)
    end
  
    it 'should return 1667' do
        assert_equal(1667, @high_income.super)
    end
  end
end
