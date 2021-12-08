require 'set'

def first
  file = File.open('input/day8.txt')
  ar = file.map do |line|
    line[0...-1].split(' | ').map { |digs| digs.split(' ') }
  end
  set = Set.new([2, 4, 3, 7])

  res = 0

  ar.each do |v|
    _, output = v

    res += output.count { |code| set.include?(code.size)  }
  end

  res
end

def asc(map)
  map.map { |k,v| [v.chars.sort ,k] }.to_h
end

def sort(m)
  m.chars.sort
end

def decode(codes)
  map = {}
  by_len = {
    2 => 1,
    4 => 4,
    3 => 7,
    7 => 8
  }

  set = Set.new
  codes.each do |code|
    if by_len.key?(code.size)
      map[by_len[code.size]] = code
      set << code
    end
  end

  codes.each do |code|
    if (code.chars - map[4].chars).size == 2 && code.size == 6
      map[9] = code
      set << code
    end
    if code.size == 6 && code != map[9] && (map[7].chars - code.chars).size == 0 &&
      map[0] = code
      set << code
    end
    if code.size == 5 && (map[1].chars - code.chars).size == 0
      map[3] = code
      set << code
    end
    if code.size == 6 && code != map[9] && (map[7].chars - code.chars).size == 1 &&
      map[6] = code
      set << code
    end
  end
  codes.each do |code|
    if code.size == 5 && (map[9].chars & code.chars).size == 4
      map[2] = code
      set << code
    end
  end
  codes.each do |code|
    map[5] = code unless set.include?(code)
  end

  asc(map)
end

def second
  file = File.open('input/day8.txt')
  ar = file.map do |line|
    line[0...-1].split(' | ').map { |digs| digs.split(' ') }
  end

  res = 0

  ar.each do |v|
    codes, output = v

    dc = decode(codes)
    res += output.map { |code| dc[sort(code)] }.join.to_i
  end

  res
end

p second