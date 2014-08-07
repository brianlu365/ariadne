#!/usr/bin/env ruby
$:.unshift File.expand_path './lib', File.dirname(__FILE__)
require "rubygems"
require "arduino_firmata"
require "motors"

astar = ArduinoFirmata.connect ARGV.shift
puts "firmata version #{astar.version}"


astar.pin_mode 13, ArduinoFirmata::OUTPUT
astar.pin_mode 10, ArduinoFirmata::OUTPUT #r_pwm
astar.pin_mode 9, ArduinoFirmata::OUTPUT #l_pwm
astar.pin_mode 8, ArduinoFirmata::OUTPUT #r_dir
astar.pin_mode 7, ArduinoFirmata::OUTPUT #l_dir

m = Motors.new(uc: astar,
               left_motor_pwm_pin: 9,
               left_motor_dir_pin: 7,
               right_motor_pwm_pin: 10,
               right_motor_dir_pin: 8)
0.upto 200 do |i|
  m.forward i
  sleep 0.1
end
sleep 1

m.break
sleep 0.2

m.reverse 100
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