class Encoder

  def initialize(args)
    @uc = args[:uc]
    @l_1_pin = args[:left_motor_encoder_a]
    @l_2_pin = args[:left_motor_encoder_b]
    @r_1_pin = args[:right_motor_encoder_a]
    @r_2_pin = args[:right_motor_encoder_b]
  end

  

end