def maybe_inc(h, x, y)
  key = "#{x},#{y}"
  (h[key] += 1) == 2 ? 1 : 0
end

def first
  file = File.open('input/day5.txt')
  lines = file.readlines

  parsed = lines.map { |l| l.split(' -> ').map { |t| t.split(',').map(&:to_i) }.flatten }
  dots = Hash.new(0)
  res = 0
  parsed.each do |pair|
    x1, y1, x2, y2 = pair
    y1, y2 = y2, y1 if y1 > y2
    x1, x2 = x2, x1 if x1 > x2

    if x1 == x2
      (y1..y2).to_a.each do |y|
        res += maybe_inc(dots, x1, y)
      end
    elsif y1 == y2
      (x1..x2).to_a.each do |x|
        res += maybe_inc(dots, x, y1)
      end
    end
  end

  res
end

def diagonal?(x1, y1, x2, y2)
  (y2 - y1).abs == (x2 - x1).abs
end

def second
  file = File.open('input/day5.txt')
  lines = file.readlines

  parsed = lines.map { |l| l.split(' -> ').map { |t| t.split(',').map(&:to_i) }.flatten }
  dots = Hash.new(0)
  res = 0
  parsed.each do |pair|
    x1, y1, x2, y2 = pair

    if diagonal?(x1, y1, x2, y2)
      x_step = x1 > x2 ? -1 : 1
      y_step = y1 > y2 ? -1 : 1
      (x1..x2).step(x_step).to_a.each do |x|
        res += maybe_inc(dots, x, y1)

        y1 += y_step
      end
    elsif x1 == x2
      y1, y2 = y2, y1 if y1 > y2
      (y1..y2).to_a.each do |y|
        res += maybe_inc(dots, x1, y)
      end
    elsif y1 == y2
      x1, x2 = x2, x1 if x1 > x2
      (x1..x2).to_a.each do |x|
        res += maybe_inc(dots, x, y1)
      end
    end
  end

  res
end
