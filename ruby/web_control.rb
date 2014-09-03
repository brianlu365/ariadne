#!/usr/bin/env ruby
$:.unshift File.expand_path './lib', File.dirname(__FILE__)
require "rubygems"
require "arduino_firmata"
require "motors"
require 'sinatra'
require 'sinatra-websocket'
require 'haml'



set :bind, '0.0.0.0'
set :port, 5678
set :server, 'thin'
set :sockets, []

get '/' do
  astar = ArduinoFirmata.connect ARGV.shift, nonblock_io: false
  puts "firmata version #{astar.version}"

  m = Motors.new(uc: astar,
                 left_motor_pwm_pin: 9,
                 left_motor_dir_pin: 7,
                 right_motor_pwm_pin: 10,
                 right_motor_dir_pin: 8)

  if !request.websocket?
    haml :index
  else
    request.websocket do |ws|
      ws.onopen do
        ws.send("Welcome!")
        settings.sockets << ws
      end

      ws.onmessage do |msg|
        case msg
        when 'forward'
          m.forward(100)
          sleep 0.5
          m.break
          msg = "went #{msg}"
        when 'backward'
          m.reverse(100)
          sleep 0.5
          m.break
          msg = "went #{msg}"
        when 'left'
          m.rotate_left(15)
          sleep 0.5
          m.break
          msg = "turned #{msg}"
        when 'right'
          m.rotate_right(15)
          sleep 0.5
          m.break
          msg = "turned #{msg}"
        end

        EM.next_tick { settings.sockets.each{|s| s.send(msg) } }
      end

      ws.onclose do
        warn("websocket closed")
        settings.sockets.delete(ws)
      end
    end
  end
end

