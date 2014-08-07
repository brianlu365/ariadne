class Qtr
  def initialize(args)
    @uc = args[:uc]
    @l_p = args[:left_pin]
    @r_p = args[:right_pin]
    @f_1_p = args[:front_1_pin]
    @f_2_p = args[:front_2_pin]
    @f_3_p = args[:front_3_pin]
    @cali_min = [32, 40, 40, 40, 32]
    @cali_max = [960, 920, 920, 920, 960]
    @last_position = 0
  end

  def l
    @uc.analog_read @l_p
  end

  def r
    @uc.analog_read @r_p
  end

  def f
    res = []
    [@f_1_p, @f_2_p, @f_3_p].each do |p|
      res << @uc.analog_read(p)
    end
    res
  end

  def vals_raw
    res = []
    [@l_p, @f_1_p, @f_2_p, @f_3_p, @r_p].each do |p|
      res << @uc.analog_read(p)
    end
    res
  end

  def vals_cali
    res = []
    vals_raw.each_with_index do |v, i|
      res << limit(v, @cali_min[i], @cali_max[i])
    end
    res
  end

  def position
    vals = vals_cali
    avg = 0
    sum = 0
    online = false


    1.upto 3 do |i|
      if vals[i] > 200
        online = true
      end
      if vals[i] > 50
        avg += vals[i] * ((i - 1) * 1000)
        sum += vals[i]
      end
    end

    unless online
      if @last_value < 1000
        return 0
      else
        return 2000
      end
    end

    @last_value = avg/sum
  end

  private
  def limit(x, a, b)
    [[x,b].min, a].max
  end
end
