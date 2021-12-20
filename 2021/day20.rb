def default(hash, step)
  return '.' if hash[0] == '.'
  step % 2 == 1 ? '.' : '#'
end

def to_vector(input, center_x, center_y, step, hash)
  res = ''
  (center_x - 1..center_x + 1).each do |x|
    (center_y - 1..center_y + 1).each do |y|
      if x < 0 || y < 0 || x >= input.size || y >= input[0].size
        res << default(hash, step)
      else
        res << input[x][y]
      end
    end
  end

  res.chars.map { |v| v == '#' ? '1' : '0' }.join
end

def bright?(val, hash)
  hash[val.to_i(2)] == '#' ? '#' : ' '
end

def to_bin(input, hash, step)
  res = []
  for i in -1..input.size
    row = []
    for j in -1..input[0].size
      row << bright?(to_vector(input, i, j, step, hash), hash)
    end
    res << row
  end

  res
end


def first
  ar = File.open('input/day20.txt').readlines.map(&:strip)

  hash = ar[0]
  input = ar[2..-1]

  img = input
  # that's second, for the first change 50 to 2.
  (1..50).each do |step|
    img = to_bin(img, hash, step)
  end

  res = 0
  for i in 0...img.size
    for j in 0...img[0].size
      res += 1 if img[i][j] == '#'
    end
  end

  res
end

