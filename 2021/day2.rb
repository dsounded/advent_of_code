def first
  file = File.open('input/day2.txt')
  measurements = file.readlines

  forward = 0
  depth = 0

  for i in 0...measurements.size
    dir, n = measurements[i].split(' ')
    n = n.to_i

    if dir == 'forward'
      forward += n
    elsif dir == 'down'
      depth += n
    elsif dir == 'up'
      depth -= n
    end
  end

  depth * forward
end

def second
  file = File.open('input/day2.txt')
  measurements = file.readlines

  forward = 0
  depth = 0
  aim = 0

  for i in 0...measurements.size
    dir, n = measurements[i].split(' ')
    n = n.to_i

    if dir == 'forward'
      forward += n
      depth += aim * n
    elsif dir == 'down'
      aim += n
    elsif dir == 'up'
      aim -= n
    end
  end

  depth * forward
end
