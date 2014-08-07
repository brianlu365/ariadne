#!/usr/bin/env ruby
$:.unshift File.expand_path './lib', File.dirname(__FILE__)
require "rubygems"
require "arduino_firmata"
require "encoder"

astar = ArduinoFirmata.connect ARGV.shift
puts "firmata version #{astar.version}"

astar.pin_mode 13, ArduinoFirmata::OUTPUT
astar.pin_mode 4, ArduinoFirmata::INPUT #l_a
astar.pin_mode 5, ArduinoFirmata::INPUT #l_b
astar.pin_mode 3, ArduinoFirmata::INPUT #r_a
astar.pin_mode 2, ArduinoFirmata::INPUT #r_b

e = Encoder.new(uc: astar, 
                left_motor_encoder_a: 4,
                left_motor_encoder_b: 5,
                right_motor_encoder_a: 3,
                right_motor_encoder_b: 2)
counter = 0
astar.on :digital_read do |pin, status|
  counter += 1
  puts "#{counter}: digital pin #{pin} changed : #{status}"
end

led_stat = false
loop do
  astar.digital_write 13, led_stat
  led_stat = !led_stat
  sleep 1
end