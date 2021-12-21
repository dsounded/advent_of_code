def move(cur, pl)
  sum = cur + pl

  sum % 10 == 0 ? 10 : sum % 10
end

def first
  ar = File.open('input/day21.txt').readlines.map(&:strip)

  pos = ar.map { |v| v.split(':').last.to_i }
  score = [0, 0]

  first = true

  start = 0
  winner = nil
  while true
    idx = first ? 0 : 1

    3.times do
      start += 1
      pos[idx] = move(pos[idx], start)
    end

    score[idx] += pos[idx]

    if score[idx] >= 1000
      winner = idx
      break
    end

    first = !first
  end

  idx = (winner - 1).abs
  score[idx] * times
end

@combs = [1,1,1,2,2,2,3,3,3].permutation(3).to_a.uniq

def simulate(first, score, pos, memo = {})
  idx = first ? 0 : 1
  other = (1 - idx).abs
  res = []

  cur_score = score[other]

  if cur_score >= 21
    res[idx] = 0
    res[other] = 1
    return res
  end

  key = "#{first},#{score},#{pos}"
  return memo[key] if memo.key?(key)

  wins = [0, 0]
  @combs.each do |c|
    score_was = score[idx]
    pos_was = pos[idx]
    pos[idx] = move(pos[idx], c.sum)
    score[idx] += pos[idx]

    res = simulate(!first, score, pos, memo)
    wins[0] += res[0]
    wins[1] += res[1]

    score[idx] = score_was
    pos[idx] = pos_was
  end

  memo[key] = wins
end

def second
  ar = File.open('input/day21.txt').readlines.map(&:strip)

  pos = ar.map { |v| v.split(':').last.to_i }
  score = [0, 0]

  simulate(true, score, pos).max
end
