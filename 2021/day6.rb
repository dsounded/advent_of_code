def first
  file = File.open('input/day6.txt')
  ar = file.readlines[0].split(',').map(&:to_i)

  80.times do
    size = ar.size
    for i in 0...size
      if ar[i] == 0
        ar[i] = 6
        ar << 8
      else
        ar[i] -= 1
      end
    end
  end

  ar.count
end

def second
  file = File.open('input/day6.txt')
  ar = file.readlines[0].split(',').map(&:to_i)

  count = Array.new(9, 0)
  ar.each do |v|
    count[v] += 1
  end

  256.times do
    gen = Array.new(9, 0)

    i = 8
    while i >= 0
      v = count[i]
      if i == 0
        gen[8] = v
        gen[6] += v
      else
        gen[i - 1] = v
      end

      i -= 1
    end

    count = gen
  end

  count.sum
end
