require 'set'
require 'algorithms'

def low?(ar, i, j)
  dirs = [[1,0], [-1, 0], [0,1], [0,-1]]

  dirs.each do |dir|
    ii = i + dir[0]
    jj = j + dir[1]

    if ii >= 0 && ii < ar.size && jj >= 0 && jj < ar[0].size
      return false if ar[i][j] >= ar[ii][jj]
    end
  end

  true
end

def first
  file = File.open('input/day9.txt')

  ar = file.readlines.map { |l| l.chomp.chars.map(&:to_i) }
  res = 0

  for i in 0...ar.size
    for j in 0...ar[0].size
      res += (ar[i][j] + 1) if low?(ar, i, j)
    end
  end

  res
end

def process_low(ar, i, j, visited)
  sum = 1
  dirs = [[1,0], [-1, 0], [0,1], [0,-1]]

  dirs.each do |dir|
    ii = i + dir[0]
    jj = j + dir[1]

    key = "#{ii},#{jj}"
    if ii >= 0 && ii < ar.size && jj >= 0 && jj < ar[0].size && ar[ii][jj] != 9 && visited.add?(key)
      sum += process_low(ar, ii, jj, visited)
    end
  end

  sum
end

def second
  file = File.open('input/day9.txt')

  ar = file.readlines.map { |l| l.chomp.chars.map(&:to_i) }
  lows = []

  for i in 0...ar.size
    for j in 0...ar[0].size
      lows << [i, j] if low?(ar, i, j)
    end
  end

  h = Containers::MinHeap.new

  lows.each do |l|
    h << process_low(ar, l[0], l[1], Set.new(["#{l[0]},#{l[1]}"]))
    h.pop if h.size > 3
  end

  res = 1
  while h.size > 0
    res *= h.pop
  end

  res
end
