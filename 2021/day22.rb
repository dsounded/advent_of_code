require 'set'

def safe_range(r)
  start = [-50, r.begin].max
  finish = [50, r.end].min
  start..finish
end

def first
  ar = File.open('input/day22.txt').readlines.map(&:strip)
  on_off = ar.map { |l| l[0..2] == 'off' ? false : true }
  ranges = ar.map { |l| l.scan(/\-?\d+\.{2}\-?\d+/) }

  s = Set.new
  res = 0
  ranges.each_with_index do |range, i|
    p i
    safe_range(eval(range[2])).each do |z|
      safe_range(eval(range[1])).each do |y|
        safe_range(eval(range[0])).each do |x|
          res += 1 if on_off[i] && s.add?("#{x},#{y},#{z}")
          res -= 1 if !on_off[i] && s.delete?("#{x},#{y},#{z}")
        end
      end
    end
  end

  res
end

def in_range?(r1, r2)
  x1, x2, y1, y2, z1, z2 = r1
  cx1, cx2, cy1, cy2, cz1, cz2 = r2

  x1 > cx2 || x2 < cx1 || y1 > cy2 || y2 < cy1 || z1 > cz2 || z2 < cz1
end

def second
  ar = File.open('input/day22.txt').readlines.map(&:strip)
  on_off = ar.map { |l| l[0..2] == 'off' ? false : true }
  ranges = ar.map { |l| l.scan(/\-?\d+\.{2}\-?\d+/) }.map { |l| l.map { |p| p.split('..').map(&:to_i) }.flatten }

  cubes = []
  ranges.each_with_index do |r, i|
    to_remove = Set.new
    x1, x2, y1, y2, z1, z2 = r
    on = on_off[i]
    for j in 0...cubes.size
      cx1, cx2, cy1, cy2, cz1, cz2 = cubes[j]

      next if in_range?(r, cubes[j])

      to_remove << j

      if x1 > cx1
        cubes << [cx1, x1 - 1, cy1, cy2, cz1, cz2]
      end
      if x2 < cx2
        cubes << [x2 + 1, cx2, cy1, cy2, cz1, cz2]
      end
      if y1 > cy1
        cubes << [[x1,cx1].max, [x2, cx2].min, cy1, y1 - 1, cz1, cz2]
      end
      if y2 < cy2
        cubes << [[x1,cx1].max, [x2, cx2].min, y2 + 1, cy2, cz1, cz2]
      end
      if z1 > cz1
        cubes << [[x1,cx1].max, [x2, cx2].min, [y1, cy1].max, [y2, cy2].min, cz1, z1 - 1]
      end
      if z2 < cz2
        cubes << [[x1,cx1].max, [x2, cx2].min, [y1, cy1].max, [y2, cy2].min, z2 + 1, cz2]
      end
    end

    if on
      cubes << [x1, x2, y1, y2, z1, z2]
    end

    new_cubes = []
    cubes.each_with_index do |c, i|
      next if to_remove.include?(i)

      new_cubes << c
    end

    cubes = new_cubes
  end

  res = 0

  cubes.each do |cube|
    x1, x2, y1, y2, z1, z2 = cube
    res += (x2 - x1 + 1) * (y2 - y1 + 1) * (z2 - z1 + 1)
  end

  res
end
