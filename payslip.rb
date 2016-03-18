require 'smarter_csv'
require 'pry'

module Payslip
  class Generate
    def initialize(user:)
      @user = user
    end

    def calculate
      get_month
    end

    def get_month
      @user[:payment_start_date]
    end

    def gross_income
      @user[:annual_salary].fdiv(12).round(0)
    end

    def income_tax
      case @user[:annual_salary]
      when 0..18_200
        0
      when 18_201..37_000
        ((@user[:annual_salary] - 18_200 * 0.19) / 12).round(0)
      when 37_001..80_000
        ((3_572 + (@user[:annual_salary] - 37_000) * 0.325) / 12).round(0)
      when 80_001..180_000
        ((17_547 + (@user[:annual_salary] - 80_000) * 0.37) / 12).round(0)
      else
        ((54_547 + (@user[:annual_salary] - 180_000) * 0.45) / 12).round(0)
      end
    end

    def net_income
      gross_income - income_tax
    end

    def super
      (gross_income * (@user[:"super_rate_%"].to_f / 100)).round(0)
    end
  end
end

#Payslip::Generate.new(input: SmarterCSV.process('input.csv')).calculate
