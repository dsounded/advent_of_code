require 'set'

def small?(c)
  c[0].ord >= 'a'.ord && c[0].ord <= 'z'.ord
end

def dfs(p, g, visited)
  if p == 'end'
    @res += 1
    return
  end

  if small?(p) && visited.include?(p)
    return
  end

  visited << p

  g[p].each do |opt|
    dfs(opt, g, visited)
  end

  visited.delete(p)
end

def first
  file = File.open('input/day12.txt')
  ar = file.readlines.map { |l| l.chomp.split('-') }

  g = {}
  ar.each do |v|
    g[v[0]] ||= []
    g[v[1]] ||= []
    g[v[0]] << v[1]
    g[v[1]] << v[0]
  end

  @res = 0
  dfs('start', g, Set.new)
  @res
end

def dfs2(p, g, visited = Set.new, visited_small = nil)
  if p == 'end'
    @res += 1
    return
  end

  if small?(p) && visited_small && visited.include?(p)
    return
  end

  if small?(p) && !visited_small && visited.include?(p)
    visited_small = p
  end

  visited << p if small?(p)

  g[p].each do |opt|
    next if opt == 'start'
    dfs2(opt, g, visited, visited_small)
  end

  if p != visited_small
    visited.delete(p)
  end
end

def second
  file = File.open('input/day12.txt')
  ar = file.readlines.map { |l| l.chomp.split('-') }

  g = {}
  ar.each do |v|
    g[v[0]] ||= []
    g[v[1]] ||= []
    g[v[0]] << v[1]
    g[v[1]] << v[0]
  end

  @res = 0
  dfs2('start', g)
  @res
end
