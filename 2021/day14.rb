def first
  ar = File.open('input/day14.txt').readlines.to_a

  pat = ar[0].strip
  rules = ar[2..-1].map { |v| v.strip.split(' -> ') }.to_h

  cur = pat
  10.times do
    i = 0
    new_cur = ''

    while i < cur.size - 1
      pair = cur[i] + cur[i + 1]

      new_cur += cur[i]

      new_cur += rules[pair] if rules.key?(pair)

      new_cur += cur[i + 1] if i == cur.size - 2

      i += 1
    end
    cur = new_cur
  end

  min = Float::INFINITY
  max = -Float::INFINITY
  cur.chars.tally.each do |_, v|
    min = [min, v].min
    max = [max, v].max
  end

  max - min
end

def second
  ar = File.open('input/day14.txt').readlines.to_a

  pat = ar[0].strip
  rules = ar[2..-1].map { |v| v.strip.split(' -> ') }.to_h
  init = Hash.new(0)

  for i in 1...pat.size
    init[pat[i - 1] + pat[i]] += 1
  end

  40.times do
    new_init = Hash.new(0)
    init.each do |k, v|
      new_init[k[0] + rules[k]] += v
      new_init[rules[k] + k[1]] += v
    end

    init = new_init
  end

  init.values.sum

  r = Hash.new(0)
  init.each do |k, v|
    r[k[0]] += v
    r[k[1]] += v
  end

  min = Float::INFINITY
  max = -Float::INFINITY
  r.each do |_, v|
    min = [min, v.fdiv(2).ceil].min
    max = [max, v.fdiv(2).ceil].max
  end

  max - min
end
