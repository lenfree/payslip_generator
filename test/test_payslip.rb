require 'csv'
require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/spec'
require_relative './../payslip'
require 'pry'

Minitest::Reporters.use!(Minitest::Reporters::SpecReporter.new)

describe 'Payslip' do
  before do
    csv = CSV.read(File.dirname(__FILE__) + '/' + 'input.csv', headers: true).map{ |row| row.to_hash }
    @entry = Payslip::Generate.new(user: csv.first)
    @high_income = Payslip::Generate.new(user: csv.last)
  end

  describe 'calculate' do
    it 'should return David' do
      assert_equal('David', @entry.first_name)
    end

    it 'should return Rudd' do
      assert_equal('Rudd', @entry.last_name)
    end

    it 'should return March' do
      assert_equal('01 March - 31 March', @entry.get_month)
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
      assert_equal(450, @entry.superannuation)
    end
  
    it 'should return 1667' do
        assert_equal(1667, @high_income.superannuation)
    end

    it 'should return csv output' do
      output = {
        'name'         => 'David Rudd',
        'pay period'   => '01 March - 31 March',
        'gross income' => '5004',
        'income tax'   => '922',
        'net income'   => '4082',
        'super'        => '450'
      }
      assert_equal(output, @entry.generate_output_csv)
    end

    it 'should return csv output' do
      output = {
        'name'         => 'Jane Doe',
        'pay period'   => '01 March - 31 March',
        'gross income' => '16667',
        'income tax'   => '5296',
        'net income'   => '11371',
        'super'        => '1667'
      }
      assert_equal(output, @high_income.generate_output_csv)
    end
  end
end
