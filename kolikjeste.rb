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

def current_year
  date = Time.new
  year_now = date.strftime('%Y')
end

def current_date(date_string)
  date = Time.new
  current_date = date.strftime(date_string)
end

def name_date(name)

  all_names = read_file('svatky.txt','r')
=begin
  current_date = date.strftime('%Y.%m.%d.')
current_date = date.strftime('2016.3.10.')
=end
  date = current_date('2016.3.10.')
  year = current_year
  puts date
  puts year

  name_date = all_names.select { |key, value| key == name}
  puts name_date

  if name_date.any?
    flip_name_date = year + '.' +
        name_date[name].split('.')[1] +'.' +
        name_date[name].split('.')[0]+'.'

    puts flip_name_date

    start_date = Date.parse date
    puts start_date

    end_date =  Date.parse flip_name_date
    puts end_date

    date_difference = (end_date - start_date).to_i

    if date_difference == 0
      puts 'Congratulations'
    elsif date_difference < 0
      year = year.to_i + 1

      puts Date.leap?(year)

      #abort
      flip_name_date = year.to_s + '.' + name_date[name].split('.')[1] +'.'+ name_date[name].split('.')[0]+'.'
      start_date = Date.parse date
      end_date =  Date.parse flip_name_date
      date_difference = (end_date - start_date).to_i
      puts "You have to wait #{date_difference} more days"
    else
      puts "You have to wait #{date_difference} more days"
    end
  else
    puts 'We are sorry but we don\'t know when you should celebrate'
  end
end

name_date(ARGV[0])
