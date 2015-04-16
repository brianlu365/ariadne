class Robot
  def initialize(args)
    @uc = args[:uc]
    @motors = args[:motors]
    @encoder = args[:encoder]
    @qtr = args[:qtr]
    @speed = 20
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
    until (false) do
      position = @qtr.position
      offset_from_center = position - 1000
      power_difference = offset_from_center / 20

      if power_difference > @speed || power_difference < -@speed
        power_difference = @speed
      end

      # puts "pos: #{position}, ofc: #{offset_from_center}, pd: #{power_difference}"

      if offset_from_center > 0
        # puts "adjust to right, #{@speed + power_difference}, #{@speed}"
        @motors.set_speed (@speed + power_difference), @speed
      else
        # puts "adjust to left, #{@speed}, #{@speed - power_difference}"
        @motors.set_speed @speed, (@speed - power_difference)
      end
      # sleep 0.02
    end
  end

  def turn(dir)
    case dir
    when :left
      @motors.left @speed
    when :right
      @motors.right @speed
    when :around
      @motors.rotate_left @speed
    end
  end
end