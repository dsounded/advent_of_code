def first
  file = File.open('input/day10.txt')
  ar = file.readlines.map { |l| l.chomp }

  invalid = {
    ')' => 3,
    ']' => 57,
    '}' => 1197,
    '>' => 25137
  }
  res = 0

  ar.each do |l|
    s = []

    l.chars.each do |c|
      if c == '('
        s << ')'
      elsif c == '['
        s << ']'
      elsif c == '{'
        s << '}'
      elsif c == '<'
        s << '>'
      elsif s.pop != c
        res += invalid[c]
        break
      end
    end
  end

  res
end

def second
  file = File.open('input/day10.txt')
  ar = file.readlines.map { |l| l.chomp }

  missing = {
    ')' => 1,
    ']' => 2,
    '}' => 3,
    '>' => 4
  }
  scores = []

  ar.each do |l|
    s = []

    l.chars.each do |c|
      if c == '('
        s << ')'
      elsif c == '['
        s << ']'
      elsif c == '{'
        s << '}'
      elsif c == '<'
        s << '>'
      elsif s.pop != c
        s = []
        break
      end
    end

    if s.any?
      i = s.size - 1

      acc = 0
      while i >= 0
        acc = acc * 5 + missing[s[i]]

        i -= 1
      end
      scores << acc
    end
  end

  mid = scores.size / 2
  scores.sort[mid]
end
