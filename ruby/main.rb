#!/usr/bin/env ruby
$:.unshift File.expand_path './lib', File.dirname(__FILE__)
require "rubygems"
require "arduino_firmata"
require "qtr"

astar = ArduinoFirmata.connect ARGV.shift
puts "firmata version #{astar.version}"


astar.pin_mode 13, ArduinoFirmata::OUTPUT #led
# motors
astar.pin_mode 10, ArduinoFirmata::OUTPUT #r_pwm
astar.pin_mode 9, ArduinoFirmata::OUTPUT #l_pwm
astar.pin_mode 8, ArduinoFirmata::OUTPUT #r_dir
astar.pin_mode 7, ArduinoFirmata::OUTPUT #l_dir
# qtr
astar.pin_mode 'A1', ArduinoFirmata::INPUT #r_qtr
astar.pin_mode 'A2', ArduinoFirmata::INPUT #l_qtr
astar.pin_mode 'A3', ArduinoFirmata::INPUT #f1_qtr
astar.pin_mode 'A4', ArduinoFirmata::INPUT #f2_qtr
astar.pin_mode 'A5', ArduinoFirmata::INPUT #f3_qtr


q = Qtr.new(uc: astar,
           left_pin: 12,
           right_pin: 11,
           front_1_pin: 6,
           front_2_pin: 1,
           front_3_pin: 10)
0.upto 200 do |i|
  m.forward 100, 100
  sleep 0.1
end
sleep 1

m.break
sleep 0.2

m.reverse 100, 100
sleep 1

m.break
sleep 0.2

m.left 100
sleep 1

m.break
sleep 0.2

m.right 100
sleep 1

m.break
