#!/usr/bin/ruby

require_relative 'payslip'
require 'csv'

# TODO: Pass as argument so this can be dynamic
# Prepare to write to clean CSV output file
OUTPUT_FILE = "output.csv".freeze
File.delete(OUTPUT_FILE) if File.exist?(OUTPUT_FILE)

# TODO: Pass as argument so this can be dynamic
INPUT_FILE = "input.csv".freeze

employees = CSV.read(INPUT_FILE, headers: true).map{ |row| row.to_hash }
Array(employees).lazy.each do |employee|
  CSV.open(OUTPUT_FILE, "a+") do |csv|
    csv << Payslip::Generate.new(user: employee).generate_output_csv.keys if csv.count.eql? 0
    csv << Payslip::Generate.new(user: employee).generate_output_csv.values
  end
end
