#!/usr/bin/ruby

Payslip::Generate.new(input: SmarterCSV.process('input.csv')).calculate
