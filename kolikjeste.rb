#!/usr/bin/env ruby
require 'date'

names_hash = Hash.new
date = Time.new
File.open('svatky.txt', 'r').readlines.each do |line|
  names_hash[line.to_s.split(' ')[1]] = line.to_s.split(' ')[0]
end

current_date = date.strftime('%Y.%m.%d.')
year_now = date.strftime('%Y')

name_date = names_hash.select { |key, value| key == ARGV[0]}

if name_date.any?
  flip_name_date = year_now + '.' + name_date[ARGV[0]].split('.')[1] +'.'+ name_date[ARGV[0]].split('.')[0]+'.'
  start_date = Date.parse current_date
  end_date =  Date.parse flip_name_date
  date_difference = (end_date - start_date).to_i

  if date_difference == 0
    puts 'Congratulations'
  elsif date_difference < 0
    year_now = year_now.to_i + 1
    flip_name_date = year_now.to_s + '.' + name_date[ARGV[0]].split('.')[1] +'.'+ name_date[ARGV[0]].split('.')[0]+'.'
    start_date = Date.parse current_date
    end_date =  Date.parse flip_name_date
    date_difference = (end_date - start_date).to_i
    puts "You have to wait #{date_difference} more days"
  else
    puts "You have to wait #{date_difference} more days"
  end

else
  puts 'We are sorry but we don\'t know when you should celebrate'
end

