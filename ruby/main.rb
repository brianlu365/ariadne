#!/usr/bin/env ruby
require "rubygems"
require "arduino_firmata"


astar = ArduinoFirmata.connect ARGV.shift
puts "firmata version #{astar.version}"

astar.pin_mode 13, ArduinoFirmata::OUTPUT
astar.pin_mode 10, ArduinoFirmata::OUTPUT
astar.pin_mode 8, ArduinoFirmata::OUTPUT

stat = true
loop do
  puts stat
  astar.digital_write 13, stat
  astar.digital_write 8, stat
  0.upto(255) do |i|
    astar.analog_write 10, i
    sleep 0.1
  end
  stat = !stat
  astar.analog_write 10, 0
  sleep 0.1
end
