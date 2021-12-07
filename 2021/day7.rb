def first
  file = File.open('input/day7.txt')
  ar = file.readlines[0].split(',').map(&:to_i)
  opts = ar.uniq

  min = Float::INFINITY
  opts.each do |opt|
    min = [ar.inject(0) { |acc, v| acc += (v - opt).abs }, min].min
  end

  min
end

def prog(n)
  ((1 + n) * n.fdiv(2)).to_i
end

def second
  file = File.open('input/day7.txt')
  ar = file.readlines[0].split(',').map(&:to_i)
  min = ar.min
  max = ar.max
  opts = (min..max).to_a

  min = Float::INFINITY
  opts.each do |opt|
    min = [ar.inject(0) { |acc, v| acc += prog((v - opt).abs) }, min].min
  end

  min
end
