def first
  file = File.open('input/day3.txt')
  measurements = file.readlines
  ln = measurements[0].size - 1
  gamma = Array.new(ln, 0)
  size = measurements.size

  for i in 0...size
    for j in 0...ln
      gamma[j] += measurements[i][j].to_i
    end
  end

  epsilon = Array.new(ln, 0)
  for j in 0...ln
    if gamma[j] > size.fdiv(2)
      gamma[j] = 1
      epsilon[j] = 0
    else
      gamma[j] = 0
      epsilon[j] = 1
    end
  end

  gamma.join.to_i(2) * epsilon.join.to_i(2)
end


def find_sum(ar, pos)
  c = 0
  for i in 0...ar.size
    c += ar[i][pos].to_i
  end

  c
end

def second
  file = File.open('input/day3.txt')
  measurements = file.readlines
  ln = measurements[0].size - 1

  co_m = measurements.dup
  for k in 0...ln
    c = find_sum(co_m, k)
    search = c >= co_m.size.fdiv(2) ? '1' : '0'

    co_m.select! { |opt| opt[k] == search }

    break if co_m.size == 1
  end

  o_m = measurements.dup
  for k in 0...ln
    c = find_sum(o_m, k)
    search = c < o_m.size.fdiv(2) ? '1' : '0'

    o_m.select! { |opt| opt[k] == search }

    break if o_m.size == 1
  end

  co_m[0].chomp.to_i(2) * o_m[0].chomp.to_i(2)
end
