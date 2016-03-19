Generate Payslip
----------------

A simple script that generates a monthly payslip
from a input csv file. This calculates 2012-2013
tax rates.

# Note:
=======

Configuring environment with Ruby, rbenv and bundler is not
in this scope.

Getting started:
=================
$ bundle install

Run test
========
$ bundle exec rake test

Generate CSV payslip:
======================
$ bundle exec ruby generate_payslip.rb

How to:
=======
Input file is hardcoded with "input.csv". Format should be as shown below or else
this will fail:

```
first name, last name, annual salary, super rate (%), payment start date
```

Output file is hardcoded with "output.csv". Hence, once generate_payslip is
executed, below will be written into this output file

```
name,pay period,gross income,income tax,net income,super
David Rudd,01 March - 31 March,5004,922,4082,450
```
