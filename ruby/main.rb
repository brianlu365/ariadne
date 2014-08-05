#!/usr/bin/env ruby
require "rubygems"
require "arduino_firmata"


astar = ArduinoFirmata.connect ARGV.shift
puts "firmata version #{astar.version}"

astar.pin_mode 13, ArduinoFirmata::OUTPUT

stat = true
loop do
  puts stat
  astar.digital_write 13, stat
  stat = !stat
  sleep 0.1
end
