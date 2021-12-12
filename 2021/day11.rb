require 'set'

def step(ar)
  q = []

  res = 0
  for i in 0...ar.size
    for j in 0...ar[0].size
      if (ar[i][j] += 1) == 10
        q << [i, j]
      end
    end
  end

  flashed = Set.new
  until q.empty?
    i, j = q.shift

    if flashed.add?("#{i},#{j}")
      res += 1

      dirs = [[1,0],[0,1],[-1,0],[0,-1],[1,1],[-1,-1],[1,-1],[-1,1]]

      dirs.each do |dir|
        ii = i + dir[0]
        jj = j + dir[1]

        if ii >= 0 && ii < ar.size && jj >= 0 && jj < ar[0].size && !flashed.include?("#{ii},#{jj}")
          if (ar[ii][jj] += 1) == 10
            q << [ii, jj]
          end
        end
      end
    end
  end

  for i in 0...ar.size
    for j in 0...ar[0].size
      if ar[i][j] >= 10
        ar[i][j] = 0
      end
    end
  end

  res
end

def step2(ar)
  q = []

  res = 0
  for i in 0...ar.size
    for j in 0...ar[0].size
      if (ar[i][j] += 1) == 10
        q << [i, j]
      end
    end
  end

  flashed = Set.new
  until q.empty?
    i, j = q.shift

    if flashed.add?("#{i},#{j}")
      res += 1

      dirs = [[1,0],[0,1],[-1,0],[0,-1],[1,1],[-1,-1],[1,-1],[-1,1]]

      dirs.each do |dir|
        ii = i + dir[0]
        jj = j + dir[1]

        if ii >= 0 && ii < ar.size && jj >= 0 && jj < ar[0].size && !flashed.include?("#{ii},#{jj}")
          if (ar[ii][jj] += 1) == 10
            q << [ii, jj]
          end
        end
      end
    end
  end

  count = ar.size * ar[0].size

  for i in 0...ar.size
    for j in 0...ar[0].size
      if ar[i][j] >= 10
        count -= 1
        ar[i][j] = 0
      end
    end
  end

  count == 0
end

def first
  file = File.open('input/day11.txt')
  ar = file.readlines.map { |l| l.chomp.chars.map(&:to_i) }

  res = 0
  100.times do
    res += step(ar)
  end

  res
end

def second
  file = File.open('input/day11.txt')
  ar = file.readlines.map { |l| l.chomp.chars.map(&:to_i) }

  step = 1
  until step2(ar)
    step += 1
  end

  step
end
