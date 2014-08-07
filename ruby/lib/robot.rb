class Robot
  def initialize(args)
    @uc = args[:uc]
    @motors = args[:motors]
    @encoder = args[:encoder]
    @qtr = args[:qtr]
    @speed = 40
  end

  def go
    puts "robot go"
    @motors.forward @speed
  end

  def stop
    puts "robot stop"
    @motors.break
  end

  def follow_segment
    until @qtr.deadend? || @qtr.intersection? do 
      position = @qtr.position
      offset_from_center = position - 1000
      power_difference = offset_from_center / 15

      if power_difference > @speed || power_difference < -@speed
        power_difference = @speed
      end

      puts "#{position}, #{offset_from_center}, #{power_difference}"

      if power_difference < 0
        puts "adjust to right"
        @motors.set_speed (@speed + power_difference), @speed
      else
        puts "adjust to left"
        @motors.set_speed @speed, (@speed + power_difference)
      end
    end
  end
end