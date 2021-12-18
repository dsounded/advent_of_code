def get_pair(str, from)
  to = from
  while str[to] != ']'
    to += 1
  end

  [str[from...to].split(',').map(&:to_i), to]
end

def number?(c)
  c.ord >= '0'.ord && c.ord <= '9'.ord
end

def add_number(str, n, right: false)
  i = if right
        try = str.rindex(/\d/)
        if try
          while try >= 1 && number?(str[try-1])
            try -= 1
          end

          try
        end
      else
        str.index(/\d/)
      end
  start = i
  return str unless i

  d = 0

  while i < str.size && number?(str[i])
    d *= 10
    d += str[i].ord - '0'.ord
    i += 1
  end

  d += n

  str[0...start] + d.to_s + str[i..-1]
end

def explode(str)
  open = 0

  pair = nil
  from = nil; to = nil

  for i in 0...str.size
    c = str[i]
    if c == '['
      if (open += 1) == 5
        from = i
        pair, to = get_pair(str, i + 1)
        break
      end
    elsif c == ']'
      open -= 1
    end
  end

  if from && to
    str = "#{add_number(str[0...from], pair[0], right: true)}0#{add_number(str[to + 1..-1], pair[1])}"

    return reduce(str)
  end

  str
end

def split(str)
  prev = nil
  cur = ''
  for i in 0...str.size
    c = str[i]
    if c == '['
      cur = ''
    elsif c == ']'
      cur = ''
    elsif c == ','
      cur = ''
    else
      cur += c

      if cur.size > 1
        prev = i - cur.size + 1
        break
      end
    end
  end

  if prev
    to = prev

    while number?(str[to])
      to += 1
    end

    n = str[prev...to].to_i

    p1 = n / 2
    p2 = n.fdiv(2).ceil

    str = "#{str[0...prev]}[#{p1},#{p2}]#{str[to..-1]}"
    return reduce(str)
  end

  str
end

def reduce(str)
  init = str
  str = explode(str)

  return reduce(str) if str != init

  init = str
  str = split(str)
  return reduce(str) if str != init

  str
end

def to_v(str)
  clean = str[1...-1].split(',').map(&:to_i)

  clean[0] * 3 + clean[1] * 2
end

def magnitude(str)
  while str.match(/\[\d+\,\d+\]/)
    start = str.scan((/\[\d+\,\d+\]/))

    if start.any?
      str.sub!(start[0], to_v(start[0]).to_s)
    end
  end

  str.to_i
end

def first
  ar = File.open('input/day18.txt').readlines.map(&:strip)

  sum = ar[0]

  for i in 1...ar.size
    sum = "[#{sum},#{ar[i]}]"

    sum = reduce(sum)
  end

  magnitude(sum)
end

def second
  ar = File.open('input/day18.txt').readlines.map(&:strip)

  max = 0
  ar.combination(2).each do |pair|
    str = "[#{pair[0]},#{pair[1]}]"
    v = magnitude(reduce(str))
    max = [max, v].max
    str2 = "[#{pair[1]},#{pair[0]}]"
    v2 = magnitude(reduce(str2))
    max = [max, v2].max
  end

  max
end
