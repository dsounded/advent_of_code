require 'set'

def parse
  file = File.open('input/day13.txt')

  ar = []
  com = []
  for line in file.readlines.each
    if line[0] == 'f'
      if line.include?('x')
        com << ['x', line.split('=').last.to_i]
      else
        com << ['y', line.split('=').last.to_i]
      end
    elsif line[0] == "\n"
      next
    else
      ar << line.split(',').map(&:to_i)
    end
  end

  [ar, com]
end

def first
  ar, com = parse

  prev_x = Float::INFINITY
  prev_y = Float::INFINITY
  com.each do |fold|
    x_y, val = fold
    is_x = x_y == 'x'
    cmp_i, prev = if is_x
                    [0, prev_x]
                  else
                    [1, prev_y]
                  end
    s = Set.new
    to_fold = []

    ar.each do |d|
      if d[cmp_i] < val
        s << d
      elsif d[cmp_i] < prev
        to_fold << d
      end
    end

    to_fold.each do |d|
      r = []
      r[cmp_i] = val - (d[cmp_i] - val)
      r[(1 - cmp_i).abs] = d[(1-cmp_i).abs]

      s << r
    end

    if is_x
      prev_x = val
    else
      prev_y = val
    end

    ar = s.to_a
  end

  ar.size
end

def second
  ar, com = parse

  prev_x = Float::INFINITY
  prev_y = Float::INFINITY
  com.each do |fold|
    x_y, val = fold
    is_x = x_y == 'x'
    cmp_i, prev = if is_x
                    [0, prev_x]
                  else
                    [1, prev_y]
                  end
    s = Set.new
    to_fold = []

    ar.each do |d|
      if d[cmp_i] < val
        s << d
      elsif d[cmp_i] < prev
        to_fold << d
      end
    end

    to_fold.each do |d|
      r = []
      r[cmp_i] = val - (d[cmp_i] - val)
      r[(1 - cmp_i).abs] = d[(1-cmp_i).abs]

      s << r
    end

    if is_x
      prev_x = val
    else
      prev_y = val
    end

    ar = s.to_a
  end

  s = Set.new(ar)

  draw = Array.new(prev_y) { Array.new(prev_x, '.') }
  for i in 0...prev_y
    for j in 0...prev_x
      if s.include?([j, i])
        draw[i][j] = '*'
      end
    end
  end

  draw.each do |line|
    p line.join
  end
end
