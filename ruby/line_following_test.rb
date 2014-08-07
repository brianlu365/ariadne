#!/usr/bin/env ruby
$:.unshift File.expand_path './lib', File.dirname(__FILE__)
require "rubygems"
require "arduino_firmata"
require "eventmachine"
require "qtr"
require "motors"
require "encoder"
require "robot"

astar = ArduinoFirmata.connect ARGV.shift, non_block_io: false
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

sleep 0.1
r.follow_segment
# sleep 0.02
# until !q.above_line(2) do
#   puts q.vals_cali.to_s + q.position.to_s + "phase 1"
#   r.turn(:left)
#   sleep 0.01
# end
# until q.above_line(2) do
#   puts q.vals_cali.to_s + q.position.to_s + "phase 2"
#   r.turn(:left)
#   sleep 0.01
# end
# r.follow_segment

r.stop
astar.close