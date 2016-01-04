def get_reindeer_info(input)
  reindeer_array = []
  input.each do |info|
    data = info.match(/(\w+) can fly (\d+) km\/s for (\d+) seconds, but then must rest for (\d+) seconds/)
    reindeer = {}
    reindeer['name'] = data[1]
    reindeer['speed'] = data[2].to_i
    reindeer['time'] = data[3].to_i
    reindeer['rest'] = data[4].to_i
    reindeer_array.push(reindeer)
  end
  return reindeer_array
end

def calc_reindeer_distance(input, time)
  reindeer_array = get_reindeer_info(input)
  longest = 0
  winner = {}
  reindeer_array.each do |reindeer|
    isResting = false
    distance = 0
    while time > 0
      if isResting
        time += -reindeer['rest']
        isResting = false
      elsif time < reindeer['time']
        distance += reindeer['speed'] * time
        time = 0
      else
        distance += reindeer['speed'] * reindeer['time']
        time += -reindeer['time']
        isResting = true
      end
    end
    if distance > longest
      longest = distance
      winner = reindeer
    end
  end
  winner['distance'] = longest
  return winner
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

puts calc_reindeer_distance(INPUT, 2503)