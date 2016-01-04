def get_reindeer_info(input)
  reindeer_array = {}
  input.each do |info|
    data = info.match(/(\w+) can fly (\d+) km\/s for (\d+) seconds, but then must rest for (\d+) seconds/)
    reindeer = {}
    reindeer['name'] = data[1]
    reindeer['speed'] = data[2].to_i
    reindeer['time'] = data[3].to_i
    reindeer['rest'] = data[4].to_i
    reindeer['points'] = 0
    reindeer_array[data[1]] = (reindeer)
  end
  return reindeer_array
end

def calc_reindeer_distance(reindeer_array, time)
  longest = 0
  winner = {}
  winnerArr = []
  reindeer_array.each do |key, reindeer|
    isResting = false
    distance = 0
    timeClone = time
    while timeClone > 0
      if isResting
        timeClone += -reindeer['rest']
        isResting = false
      elsif timeClone < reindeer['time']
        distance += reindeer['speed'] * timeClone
        timeClone = 0
      else
        distance += reindeer['speed'] * reindeer['time']
        timeClone += -reindeer['time']
        isResting = true
      end
    end
    if distance > longest
      longest = distance
      winner = reindeer
      winnerArr = [winner]
    elsif distance == longest
      winnerArr.push(reindeer)
    end
  end
  winnerArr.each do |win|
    win['distance'] = longest
  end
  return winnerArr
end

def calc_reindeer_points(reindeer_array, time)
  time.times do |i|
    winning = calc_reindeer_distance(reindeer_array, i+1)
    winning.each do |winner|
      reindeer_array[winner['name']]['points'] += 1
    end
  end
  
  reindeer_arr = reindeer_array.values.sort! { |x,y| y['points'] <=> x['points']}
  return reindeer_arr
end

TEST1 = "Comet can fly 14 km/s for 10 seconds, but then must rest for 127 seconds.
Dancer can fly 16 km/s for 11 seconds, but then must rest for 162 seconds.".split("\n")

INPUT = "Vixen can fly 19 km/s for 7 seconds, but then must rest for 124 seconds.
Rudolph can fly 3 km/s for 15 seconds, but then must rest for 28 seconds.
Donner can fly 19 km/s for 9 seconds, but then must rest for 164 seconds.
Blitzen can fly 19 km/s for 9 seconds, but then must rest for 158 seconds.
Comet can fly 13 km/s for 7 seconds, but then must rest for 82 seconds.
Cupid can fly 25 km/s for 6 seconds, but then must rest for 145 seconds.
Dasher can fly 14 km/s for 3 seconds, but then must rest for 38 seconds.
Dancer can fly 3 km/s for 16 seconds, but then must rest for 37 seconds.
Prancer can fly 25 km/s for 6 seconds, but then must rest for 143 seconds.".split("\n")

#puts calc_reindeer_points(get_reindeer_info(TEST1), 1000)[0]['points']
puts calc_reindeer_points(get_reindeer_info(INPUT), 2503)[0]['points']