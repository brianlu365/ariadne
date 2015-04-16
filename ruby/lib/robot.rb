class Robot
  def initialize(args)
    @uc = args[:uc]
    @motors = args[:motors]
    @encoder = args[:encoder]
    @qtr = args[:qtr]
    @speed = 100
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
    last_error = 0

    until (false) do
      error = @qtr.position - 1000
      power_difference = error/20+(error - last_error)*2
      last_error = error


      left_spd = @speed + power_difference
      right_spd = @speed - power_difference

      # puts "pos: #{position}, ofc: #{error}, pd: #{power_difference}"

      if left_spd < 0
        left_spd = 0
      end

      if right_spd < 0
        right_spd = 0
      end

      if left_spd > @speed
        left_spd = @speed
      end

      if right_spd > @speed
        right_spd = @speed
      end

      @motors.set_speed left_spd, right_spd
      sleep 0.01
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