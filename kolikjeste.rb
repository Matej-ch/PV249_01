#!/usr/bin/env ruby
require 'date'

def read_file(file, type)
  names_hash = {}
  f = File.open(file, type)
  f.readlines.each do |row|
    names_hash[row.to_s.split(' ')[1]] = row.to_s.split(' ')[0]
  end
  f.close
  names_hash
end

def current_year_date
  date = Time.new
  [date.strftime('%Y'), date.strftime('%Y.%m.%d.')]
end

def difference(start_date, end_date)
  s_date = Date.parse start_date
  e_date =  Date.parse end_date
  (e_date - s_date).to_i
end

def get_correct_year(current, month, day)
  year = current.to_i + 1
  flag_leap = Date.leap?(year)
  until flag_leap
    year = year.to_i + 1
    flag_leap = Date.leap?(year)
  end if month.to_i == 2 && day.to_i == 29
  year.to_s
end

def check_difference(date_difference)
  puts 'Congratulations' if date_difference == 0
  if date_difference < 0
    year_new = get_correct_year(current_year_date[0], month_day[0], month_day[1])
    date_difference = difference(current_year_date[1], "#{year_new}.#{month_day[0]}.#{month_day[0]}.")
    puts "You have to wait #{date_difference} more days"
  elsif date_difference > 0
    puts "You have to wait #{date_difference} more days"
  end
end

def month_day
  name_date = read_file('svatky.txt', 'r').select { |key, _value| key == ARGV[0] }
  return name_date[ARGV[0]].split('.')[1], name_date[ARGV[0]].split('.')[0]
end

def flip_date
  name_date = read_file('svatky.txt', 'r').select { |key, _value| key == ARGV[0] }
  "#{current_year_date[0]}.#{name_date[ARGV[0]].split('.')[1]}.#{name_date[ARGV[0]].split('.')[0]}."
end

def name_date(name)
  name_date = read_file('svatky.txt', 'r').select { |key, _value| key == name }
  if name_date.any?
    date_difference = difference(current_year_date[1], flip_date)
    check_difference(date_difference)
  else
    puts 'We are sorry but we don\'t know when you should celebrate'
  end
end

name_date(ARGV[0])
