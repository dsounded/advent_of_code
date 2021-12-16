require 'algorithms'
require 'set'

def first
  ar = File.open('input/day15.txt').readlines.map { |l| l.strip.chars.map(&:to_i) }

  # dp = Array.new(ar.size) { Array.new(ar[0].size) }
  # dp[0][0] = 0
  #
  # for i in 1...ar.size
  #   dp[i][0] = dp[i - 1][0] + ar[i][0]
  # end
  #
  # for j in 1...ar.size
  #   dp[0][j] = dp[0][j - 1] + ar[0][j]
  # end
  #
  # for i in 1...ar.size
  #   for j in 1...ar.size
  #     dp[i][j] = [dp[i - 1][j], dp[i][j - 1]].min + ar[i][j]
  #   end
  # end
  #
  # dp[-1][-1]

  dkst = Array.new(ar.size) { Array.new(ar[0].size, Float::INFINITY) }
  visited = Set.new
  dkst[0][0] = 0

  h = Containers::MinHeap.new

  h.push(0, [0, 0])

  while h.size > 0
    i, j = h.pop

    key = "#{i},#{j}"
    next if visited.include?(key)

    dirs = [[0,1],[0,-1],[1,0],[-1,0]]
    dirs.each do |dir|
      ii = i + dir[0]
      jj = j + dir[1]

      if ii >= 0 && ii < ar.size && jj >= 0 && jj < ar[0].size
        if dkst[i][j] + ar[ii][jj] < dkst[ii][jj]
          dkst[ii][jj] = dkst[i][j] + ar[ii][jj]
          h.push(dkst[ii][jj], [ii, jj])
        end
      end
    end
    visited << key
  end

  dkst[-1][-1]
end

def v(v)
  return 1 if v == 9
  v + 1
end

def multiply(ar)
  new = Array.new(ar.size * 5) { Array.new(ar[0].size * 5) }
  for i in 0...ar.size
    for j in 0...ar[0].size
      new[i][j] = ar[i][j]
    end
  end

  for j in 0...ar[0].size
    for i in ar.size...new.size
      new[i][j] = v(new[i - ar.size][j])
    end
  end

  for i in 0...new.size
    for j in ar[0].size...new[0].size
      new[i][j] = v(new[i][j - ar[0].size])
    end
  end

  new
end

def second
  ar = multiply(File.open('input/day15.txt').readlines.map { |l| l.strip.chars.map(&:to_i) })

  # dp = Array.new(ar.size) { Array.new(ar[0].size) }
  # dp[0][0] = 0
  #
  # for i in 1...ar.size
  #   dp[i][0] = dp[i - 1][0] + ar[i][0]
  # end
  #
  # for j in 1...ar.size
  #   dp[0][j] = dp[0][j - 1] + ar[0][j]
  # end
  #
  # for i in 1...ar.size
  #   for j in 1...ar.size
  #     dp[i][j] = [dp[i - 1][j], dp[i][j - 1]].min + ar[i][j]
  #   end
  # end
  #
  # dp[-1][-1]

  dkst = Array.new(ar.size) { Array.new(ar[0].size, Float::INFINITY) }
  visited = Set.new
  dkst[0][0] = 0

  h = Containers::MinHeap.new

  h.push(0, [0, 0])

  while h.size > 0
    i, j = h.pop

    key = "#{i},#{j}"
    next if visited.include?(key)

    dirs = [[0,1],[0,-1],[1,0],[-1,0]]
    dirs.each do |dir|
      ii = i + dir[0]
      jj = j + dir[1]

      if ii >= 0 && ii < ar.size && jj >= 0 && jj < ar[0].size
        if dkst[i][j] + ar[ii][jj] < dkst[ii][jj]
          dkst[ii][jj] = dkst[i][j] + ar[ii][jj]
          h.push(dkst[ii][jj], [ii, jj])
        end
      end
    end
    visited << key
  end

  dkst[-1][-1]
end
