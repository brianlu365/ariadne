class Motors
  attr_accessor :left_dir, :right_dir, :left_spd, :right_spd
  def initialize(uc, left_motor_pwm_pin, left_motor_dir_pin, right_motor_pwm_pin, right_motor_dir_pin)
    @uc = uc
    @l_pwm_p, @l_dir_p, @r_pwm_p, @r_dir_p = left_motor_pwm_pin, left_motor_dir_pin, right_motor_pwm_pin, right_motor_dir_pin
    @left_spd = 0
    @right_spd = 0
    @left_dir = 0
    @right_dir = 1
  end

  def forward(l_spd, r_spd)
    set_dir 0, 1
    set_speed l_spd, r_spd
  end

  def reverse(l_spd, r_spd)
    set_dir 1, 0
    set_speed l_spd, r_spd
  end

  def left(spd)
    set_dir 0, 1
    left_spd = 0
    right_spd = spd
  end

  def right(spd)
    set_dir 0, 1
    right_spd = 0
    left_spd = spd
  end

  def rotate_left(spd)
    set_dir 1, 1
    set_speed spd, spd
  end

  def rotate_right(spd)
    set_dir 0, 0
    set_speed spd, spd
  end

  def break
    set_speed 0, 0
  end

  def left_dir=(dir)
    @uc.digital_write @l_dir_p, dir
    @left_dir = dir
  end

  def right_dir=(dir)
    @uc.digital_write @r_dir_p, dir
    @right_dir = dir
  end

  def left_spd=(spd)
    @uc.analog_write @l_spd_p, spd
    @left_spd = spd
  end

  def right_spd=(spd)
    @uc.analog_write @r_spd_p, spd
    @right_spd = spd
  end

  def set_speed(l_spd, r_spd)
    left_spd = l_spd
    right_spd = r_spd
  end

  def set_dir(l_dir, r_dir)
    left_dir = l_dir
    right_dir = r_dir
  end
end
