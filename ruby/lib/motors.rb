class Motors
  attr_reader :left_dir, :right_dir, :left_spd, :right_spd
  def initialize(args)
    @uc = args[:uc]
    @l_pwm_p, @l_dir_p, @r_pwm_p, @r_dir_p = args[:left_motor_pwm_pin], args[:left_motor_dir_pin], args[:right_motor_pwm_pin], args[:right_motor_dir_pin]
    self.left_spd = 0
    self.right_spd = 0
    self.left_dir = 0
    self.right_dir = 1
  end

  def forward(spd)
    set_dir 0, 1
    set_speed spd, spd
  end

  def reverse(spd)
    set_dir 1, 0
    set_speed spd, spd
  end

  def left(spd)
    set_dir 1, 1
    self.left_spd = spd / 2
    self.right_spd = spd
  end

  def right(spd)
    set_dir 0, 0
    self.right_spd = 0
    self.left_spd = spd
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
    puts "break"
    @uc.digital_write @l_pwm_p, 0
    @uc.digital_write @r_pwm_p, 0
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
    # spd = spd + 5
    @uc.analog_write @l_pwm_p, spd
    @left_spd = spd
  end

  def right_spd=(spd)
    @uc.analog_write @r_pwm_p, spd
    @right_spd = spd
  end

  def set_speed(l_spd, r_spd)
    self.left_spd = l_spd 
    self.right_spd = r_spd
  end

  def set_dir(l_dir, r_dir)
    self.left_dir = l_dir
    self.right_dir = r_dir
  end
end
