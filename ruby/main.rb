#!/usr/bin/env ruby
require "rubygems"
require "arduino_firmata"


astar = ArduinoFirmata.connect ARGV.shift
puts "firmata version #{astar.version}"

astar.pin_mode 13, ArduinoFirmata::OUTPUT
astar.pin_mode 9, ArduinoFirmata::OUTPUT
astar.pin_mode 7, ArduinoFirmata::OUTPUT

stat = true
loop do
  puts stat
  astar.digital_write 13, stat
  astar.digital_write 7, stat
  0.upto(200) do |i|
    astar.analog_write 9, i
    sleep 0.1
  end
  200.upto(0) do |i|
    astar.analog_write 9, i
    sleep 0.1
  end
  stat = !stat
  sleep 0.1
end
