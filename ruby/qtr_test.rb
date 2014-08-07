#!/usr/bin/env ruby
$:.unshift File.expand_path './lib', File.dirname(__FILE__)
require "rubygems"
require "arduino_firmata"
require "eventmachine"
require "qtr"

astar = ArduinoFirmata.connect ARGV.shift
puts "firmata version #{astar.version}"


q = Qtr.new(uc: astar, 
            left_pin: 0,
            right_pin: 1,
            front_1_pin: 2,
            front_2_pin: 3,
            front_3_pin: 4)
# astar.on :analog_read do |pin, value|
#   puts "analog_read #{pin} => #{value}" if [0,1,2,3,4].include? pin
# end
loop do
  # raw = q.vals_raw
  # cali = q.vals_cali
  # res = []
  # 0.upto 4 do |i|
  #   res << raw[i] - cali[i]
  # end
  # puts raw.to_s + cali.to_s + res.to_s
  puts q.position
end
