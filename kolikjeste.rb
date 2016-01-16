#!/usr/bin/env ruby
require 'date'

def read_file(file,type)
  names_hash = Hash.new
  f = File.open(file, type)
  f.readlines.each do |row|
    names_hash[row.to_s.split(' ')[1]] = row.to_s.split(' ')[0]
  end
  f.close
  names_hash
end

def current_year(year_string)
  date = Time.new
  date.strftime(year_string)
end

def current_date(date_string)
  date = Time.new
  date.strftime(date_string)
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
  year
end

def name_date(name)
  all_names = read_file('svatky.txt','r')
  date = current_date('%Y.%m.%d.')
  year = current_year('%Y')

  name_date = all_names.select { |key, value| key == name}

  if name_date.any?
    flip_name_date = year + '.' +
        name_date[name].split('.')[1] +'.' +
        name_date[name].split('.')[0]+'.'

    month = name_date[name].split('.')[1]
    day = name_date[name].split('.')[0]

    date_difference = difference(date,flip_name_date)

    if date_difference == 0
      puts 'Congratulations'
    elsif date_difference < 0
      year = get_correct_year(year, month, day)

      flip_name_date = year.to_s + '.' +
          name_date[name].split('.')[1] +'.'+ 
          name_date[name].split('.')[0]+'.'
      date_difference = difference(date,flip_name_date)
      puts "You have to wait #{date_difference} more days"
    else
      puts "You have to wait #{date_difference} more days"
    end
  else
    puts 'We are sorry but we don\'t know when you should celebrate'
  end
end

name_date(ARGV[0])
