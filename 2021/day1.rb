def first
  file = File.open('input/day1.txt')
  measurements = file.readlines.map { |r| r.chomp.to_i }

  res = 0
  for i in 1...measurements.size
    res += 1 if measurements[i] > measurements[i - 1]
  end

  res
end

def second
  file = File.open('input/day1.txt')
  measurements = file.readlines.map { |r| r.chomp.to_i }

  sum = 0

  for i in 0...3
    sum += measurements[i]
  end

  res = 0
  for i in 3...measurements.size
    pre = sum

    sum += measurements[i]

    sum -= measurements[i - 3]

    res += 1 if sum > pre
  end

  res
end
