require 'csv'
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
      @user[' payment start date']
    end

    def gross_income
      @user[' annual salary'].to_f.fdiv(12).round(0)
    end

    def income_tax
      case @user[' annual salary'].to_f
      when 0..18_200
        0
      when 18_201..37_000
        ((@user[' annual salary'].to_f - 18_200 * 0.19) / 12).round(0)
      when 37_001..80_000
        ((3_572 + (@user[' annual salary'].to_f - 37_000) * 0.325) / 12).round(0)
      when 80_001..180_000
        ((17_547 + (@user[' annual salary'].to_f - 80_000) * 0.37) / 12).round(0)
      else
        ((54_547 + (@user[' annual salary'].to_f - 180_000) * 0.45) / 12).round(0)
      end
    end

    def net_income
      (gross_income.to_f - income_tax.to_f).round(0)
    end

    def first_name
      @user['first name']
    end

    def last_name
      @user[' last name']
    end

    def superannuation
      (gross_income.to_f * (@user[" super rate (%)"].to_f / 100)).round(0)
    end

    def generate_output_csv
      ["#{first_name} #{last_name},#{get_month},#{gross_income},"\
        "#{income_tax},#{net_income},#{superannuation}"]
    end
  end
end
