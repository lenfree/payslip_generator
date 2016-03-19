#!/usr/bin/ruby

require 'csv'
require_relative 'payslip'
require 'pry'

# Prepare to write to clean CSV output file
OUTPUT_FILE = "output.csv".freeze
File.delete(OUTPUT_FILE) if File.exist?(OUTPUT_FILE)

employees = CSV.read('input.csv', headers: true).map{ |row| row.to_hash }
Array(employees).lazy.each do |employee|
  CSV.open(OUTPUT_FILE, "a+") do |csv|
      csv << Payslip::Generate.new(user: employee).generate_output_csv
  end
end
