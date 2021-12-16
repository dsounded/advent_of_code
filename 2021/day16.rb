def convert(l)
  map = {
    '0' => '0000',
    '1' => '0001',
    '2' => '0010',
    '3' => '0011',
    '4' => '0100',
    '5' => '0101',
    '6' => '0110',
    '7' => '0111',
    '8' => '1000',
    '9' => '1001',
    'A' => '1010',
    'B' => '1011',
    'C' => '1100',
    'D' => '1101',
    'E' => '1110',
    'F' => '1111'
  }

  l.chars.map { |c| map[c] }.join
end

def parse(l, start)
  v = l[start...start + 3].to_i(2)
  t = l[start + 3...start + 6].to_i(2)

  if t == 4
    bits = []
    skp = false
    cur = ''
    finish = false
    i = start + 6
    while i < l.size
      if !skp
        skp = true
        finish = true if l[i] == '0'
      else
        cur << l[i]
      end

      if cur.size == 4
        bits << cur
        skp = false
        cur = ''
        break if finish
      end

      i += 1
    end

    {v: v, t: t, value: bits.join.to_i(2), idx: i}
  else
    id = l[start + 6].to_i

    if id == 0
      len = l[start + 7...start + 22].to_i(2)

      prev = start + 22
      finish = start + 22 + len

      while prev < finish
        res = parse(l, prev)
        v += res[:v]
        prev = res[:idx] + 1
      end

      {v: v, t: t, idx: finish - 1}
    else
      c = l[start + 7...start + 18].to_i(2)

      prev = start + 18
      while c > 0
        res = parse(l, prev)
        v += res[:v]
        prev = res[:idx] + 1

        c -= 1
      end

      {v: v, t: t, idx: prev - 1}
    end
  end
end

def value(values, type)
  if type == 0
    values.sum
  elsif type == 1
    values.inject(1, :*)
  elsif type == 2
    values.min
  elsif type == 3
    values.max
  elsif type == 5
    values[0] > values[1] ? 1 : 0
  elsif type == 6
    values[0] < values[1] ? 1 : 0
  elsif type == 7
    values[0] == values[1] ? 1 : 0
  end
end

def parse2(l, start)
  v = l[start...start + 3].to_i(2)
  t = l[start + 3...start + 6].to_i(2)

  if t == 4
    bits = []
    skp = false
    cur = ''
    finish = false
    i = start + 6
    while i < l.size
      if !skp
        skp = true
        finish = true if l[i] == '0'
      else
        cur << l[i]
      end

      if cur.size == 4
        bits << cur
        skp = false
        cur = ''
        break if finish
      end

      i += 1
    end

    {v: v, t: t, value: bits.join.to_i(2), idx: i}
  else
    id = l[start + 6].to_i
    values = []

    if id == 0
      len = l[start + 7...start + 22].to_i(2)

      prev = start + 22
      finish = start + 22 + len

      while prev < finish
        res = parse2(l, prev)
        values << res[:value]
        prev = res[:idx] + 1
      end

      {v: v, t: t, idx: finish - 1, value: value(values, t)}
    else
      c = l[start + 7...start + 18].to_i(2)

      prev = start + 18
      while c > 0
        res = parse2(l, prev)
        values << res[:value]
        prev = res[:idx] + 1

        c -= 1
      end

      {v: v, t: t, idx: prev - 1, value: value(values, t)}
    end
  end
end

def first
  ar = File.open('input/day16.txt').readlines[0].strip

  parse(convert(ar), 0)[:v]
end

def second
  ar = File.open('input/day16.txt').readlines[0].strip

  parse2(convert(ar), 0)[:value]
end
