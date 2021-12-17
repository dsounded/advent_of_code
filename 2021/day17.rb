def simulate(t_x, t_y, pow_x, pow_y)
  x = 0; y = 0

  max_y = -Float::INFINITY
  while x <= t_x[1] && y >= t_y[0]
    x += pow_x
    y += pow_y

    # p "#{x},#{y}"
    max_y = [y, max_y].max

    pow_x = [pow_x - 1, 0].max
    pow_y -= 1

    return [true, max_y] if x >= t_x[0] && x <= t_x[1] && y >= t_y[0] && y <= t_y[1]
  end

  [false, -1]
end

p simulate([20, 30], [-10, -5], 8, 0)

def first
  d = File.open('input/day17.txt').readlines[0]

  t = d[15..-1].strip.split(', y=').map do |p|
    p.split('..').map(&:to_i)
  end

  x = t[0][1]

  max_v = -Float::INFINITY
  (0...x).each do |pow_x|
    (0...x.fdiv(2)).each do |pow_y|
      suc, v = simulate(t[0], t[1], pow_x, pow_y,)

      next unless suc

      max_v = [v, max_v].max
    end
  end

  max_v
end

def second
  d = File.open('input/day17.txt').readlines[0]

  t = d[15..-1].strip.split(', y=').map do |p|
    p.split('..').map(&:to_i)
  end

  x = t[0][1]
  y = t[1][0]

  res = 0

  (0..x).each do |pow_x|
    (y..x).each do |pow_y|
      suc, _ = simulate(t[0], t[1], pow_x, pow_y,)

      res += 1 if suc
    end
  end

  res
end
