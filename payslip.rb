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
  end
end

#Payslip::Generate.new(input: SmarterCSV.process('input.csv')).calculate
