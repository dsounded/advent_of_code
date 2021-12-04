require 'set'

def parse(lines)
  ar = []

  cur = []
  for i in 2...lines.size
    if lines[i] == "\n" || i == lines.size - 1
      cur << lines[i].split(' ').map { |n| n.to_i }
      ar << cur
      cur = []
    else
      cur << lines[i].split(' ').map { |n| n.to_i }
    end
  end

  ar
end

def numbers(ar)
  options = {}
  ar.each_with_index do |m, index|
    for i in 0...5
      for j in 0...5
        options[m[i][j]] ||= []
        options[m[i][j]] << [index, i, j]
      end
    end
  end

  options
end

def calculate(ar, stop, moves)
  stop_pos, m_i = stop
  moves = Set.new(moves[0..m_i])

  m = ar[stop_pos[0]]

  sum = 0
  for i in 0...5
    for j in 0...5
      sum += m[i][j] unless moves.include?(m[i][j])
    end
  end

  sum * m[stop_pos[1]][stop_pos[2]]
end

def first
  file = File.open('input/day4.txt')
  lines = file.readlines
  moves = lines[0].split(',').map { |n| n.to_i }
  ar = parse(lines)
  numbers = numbers(ar)
  opts = Array.new(ar.size)
  for i in 0...opts.size
    opts[i] = { rows: Array.new(5, 0), cols: Array.new(5, 0) }
  end

  stop = nil
  moves.each_with_index do |move, m_i|
    break if stop
    numbers[move].each do |pos|
      if (opts[pos[0]][:rows][pos[1]] += 1) == 5
        stop = [pos, m_i]
        break
      end
      if (opts[pos[0]][:cols][pos[2]] += 1) == 5
        stop = [pos, m_i]
        break
      end
    end
  end

  calculate(ar, stop, moves)
end

def second
  file = File.open('input/day4.txt')
  lines = file.readlines
  moves = lines[0].split(',').map { |n| n.to_i }
  ar = parse(lines)
  numbers = numbers(ar)
  opts = Array.new(ar.size)
  for i in 0...opts.size
    opts[i] = { rows: Array.new(5, 0), cols: Array.new(5, 0) }
  end

  stop = nil
  already_won = Set.new
  moves.each_with_index do |move, m_i|
    numbers[move].each do |pos|
      if (opts[pos[0]][:rows][pos[1]] += 1) >= 5
        stop = [pos, m_i] if already_won.add?(pos[0])
      end
      if (opts[pos[0]][:cols][pos[2]] += 1) >= 5
        stop = [pos, m_i] if already_won.add?(pos[0])
      end
    end
  end

  calculate(ar, stop, moves)
end
