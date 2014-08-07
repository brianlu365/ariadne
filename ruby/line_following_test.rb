#!/usr/bin/env ruby
$:.unshift File.expand_path './lib', File.dirname(__FILE__)
require "rubygems"
require "arduino_firmata"
require "eventmachine"
require "qtr"
require "motors"
require "encoder"
require "robot"

astar = ArduinoFirmata.connect ARGV.shift, :nonblock_io => true
puts "firmata version #{astar.version}"

q = Qtr.new(uc: astar, 
            left_pin: 0,
            right_pin: 1,
            front_1_pin: 2,
            front_2_pin: 3,
            front_3_pin: 4)
m = Motors.new(uc: astar,
               left_motor_pwm_pin: 9,
               left_motor_dir_pin: 7,
               right_motor_pwm_pin: 10,
               right_motor_dir_pin: 8)

e = Encoder.new(uc: astar, 
                left_motor_encoder_a: 4,
                left_motor_encoder_b: 5,
                right_motor_encoder_a: 3,
                right_motor_encoder_b: 2)

r = Robot.new(uc: astar,
              motors: m,
              encoder: e,
              qtr: q)


r.go
# r.follow_segment
sleep 0.5
r.stop
m.break
astar.close