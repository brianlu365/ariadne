#!/usr/bin/env ruby
$:.unshift File.expand_path './lib', File.dirname(__FILE__)
require "rubygems"
require "arduino_firmata"
require "motors"
require "qtr"
require "encoder"
require "robot"

astar = ArduinoFirmata.connect ARGV.shift
puts "firmata version #{astar.version}"


astar.pin_mode 13, ArduinoFirmata::OUTPUT
astar.pin_mode 10, ArduinoFirmata::OUTPUT #r_pwm
astar.pin_mode 9, ArduinoFirmata::OUTPUT #l_pwm
astar.pin_mode 8, ArduinoFirmata::OUTPUT #r_dir
astar.pin_mode 7, ArduinoFirmata::OUTPUT #l_dir

m = Motors.new(astar, 9, 7, 10, 8)
m.forward 100, 100
sleep 1

# m.break
# sleep 0.2

# m.reverse 100, 100
# sleep 1

# m.break
# sleep 0.2

# m.left 100
# sleep 1

# m.break
# sleep 0.2

# m.right 100
# sleep 1

# m.break
