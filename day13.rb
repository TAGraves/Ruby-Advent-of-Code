def make_people_map(peopleHash)
  peopleMap = []
  peopleHash.each_key do |key|
    peopleMap.push(key)
  end
  return peopleMap
end

def make_people_hash(data)
  peopleHash = {}
  data.each do |person|
    primary = person.split(' would')[0]
    byPerson = person.split('next to ')[1].split('.')[0]
    if person.match(/gain/)
      units = person.split('gain ')[1].split(' happiness')[0].to_i
    else
      units = -(person.split('lose ')[1].split(' happiness')[0].to_i)
    end
    if !peopleHash.has_key?(primary)
      peopleHash[primary] = {}
    end
    peopleHash[primary][byPerson] = units
  end
  return peopleHash
end

def add_self_to_hash(peopleHash)
  me = 'Me'
  peopleHash[me] = {}
  peopleHash.each_key do |person|
    if person != me
      peopleHash[person][me] = 0
      peopleHash[me][person] = 0
    end
  end
  return peopleHash
end

def calc_greatest_happiness(data)
  table = make_people_hash(data)
  people = make_people_map(table)
  most_happiness = 0
  seatings = get_permutations(people)
  seatings.each do |seating|
    i = 0
    seatingHappiness = 0
    while i < seating.length-1 do
      seatingHappiness += table[seating[i]][seating[i+1]]
      seatingHappiness += table[seating[i+1]][seating[i]]
      i += 1
    end
    seatingHappiness += table[seating[0]][seating[-1]]
    seatingHappiness += table[seating[-1]][seating[0]]
    if seatingHappiness > most_happiness
      most_happiness = seatingHappiness
    end
  end
  return most_happiness
end

def calc_greatest_happiness_with_self(data)
  table = make_people_hash(data)
  table = add_self_to_hash(table)
  people = make_people_map(table)
  most_happiness = 0
  seatings = get_permutations(people)
  seatings.each do |seating|
    i = 0
    seatingHappiness = 0
    while i < seating.length-1 do
      seatingHappiness += table[seating[i]][seating[i+1]]
      seatingHappiness += table[seating[i+1]][seating[i]]
      i += 1
    end
    seatingHappiness += table[seating[0]][seating[-1]]
    seatingHappiness += table[seating[-1]][seating[0]]
    if seatingHappiness > most_happiness
      most_happiness = seatingHappiness
    end
  end
  
  return most_happiness
end


def get_permutations(people)
  seatings = []
  i = 0
  while i < people.length
    seating = [people[i]]
    next_permutation(people, 1, seatings, seating)
    i += 1
  end
  return seatings
end

def next_permutation(people, level, seatings, seating)
  i = 0
  if level < people.length
    while i < people.length
      if !seating.include?(people[i])
        permutationSeating = seating.clone
        permutationSeating.push(people[i])
        next_permutation(people, level+1, seatings, permutationSeating)
      end
      i += 1
    end
  else
    seatings.push(seating)
  end
end

INPUT = 'Alice would lose 2 happiness units by sitting next to Bob.
Alice would lose 62 happiness units by sitting next to Carol.
Alice would gain 65 happiness units by sitting next to David.
Alice would gain 21 happiness units by sitting next to Eric.
Alice would lose 81 happiness units by sitting next to Frank.
Alice would lose 4 happiness units by sitting next to George.
Alice would lose 80 happiness units by sitting next to Mallory.
Bob would gain 93 happiness units by sitting next to Alice.
Bob would gain 19 happiness units by sitting next to Carol.
Bob would gain 5 happiness units by sitting next to David.
Bob would gain 49 happiness units by sitting next to Eric.
Bob would gain 68 happiness units by sitting next to Frank.
Bob would gain 23 happiness units by sitting next to George.
Bob would gain 29 happiness units by sitting next to Mallory.
Carol would lose 54 happiness units by sitting next to Alice.
Carol would lose 70 happiness units by sitting next to Bob.
Carol would lose 37 happiness units by sitting next to David.
Carol would lose 46 happiness units by sitting next to Eric.
Carol would gain 33 happiness units by sitting next to Frank.
Carol would lose 35 happiness units by sitting next to George.
Carol would gain 10 happiness units by sitting next to Mallory.
David would gain 43 happiness units by sitting next to Alice.
David would lose 96 happiness units by sitting next to Bob.
David would lose 53 happiness units by sitting next to Carol.
David would lose 30 happiness units by sitting next to Eric.
David would lose 12 happiness units by sitting next to Frank.
David would gain 75 happiness units by sitting next to George.
David would lose 20 happiness units by sitting next to Mallory.
Eric would gain 8 happiness units by sitting next to Alice.
Eric would lose 89 happiness units by sitting next to Bob.
Eric would lose 69 happiness units by sitting next to Carol.
Eric would lose 34 happiness units by sitting next to David.
Eric would gain 95 happiness units by sitting next to Frank.
Eric would gain 34 happiness units by sitting next to George.
Eric would lose 99 happiness units by sitting next to Mallory.
Frank would lose 97 happiness units by sitting next to Alice.
Frank would gain 6 happiness units by sitting next to Bob.
Frank would lose 9 happiness units by sitting next to Carol.
Frank would gain 56 happiness units by sitting next to David.
Frank would lose 17 happiness units by sitting next to Eric.
Frank would gain 18 happiness units by sitting next to George.
Frank would lose 56 happiness units by sitting next to Mallory.
George would gain 45 happiness units by sitting next to Alice.
George would gain 76 happiness units by sitting next to Bob.
George would gain 63 happiness units by sitting next to Carol.
George would gain 54 happiness units by sitting next to David.
George would gain 54 happiness units by sitting next to Eric.
George would gain 30 happiness units by sitting next to Frank.
George would gain 7 happiness units by sitting next to Mallory.
Mallory would gain 31 happiness units by sitting next to Alice.
Mallory would lose 32 happiness units by sitting next to Bob.
Mallory would gain 95 happiness units by sitting next to Carol.
Mallory would gain 91 happiness units by sitting next to David.
Mallory would lose 66 happiness units by sitting next to Eric.
Mallory would lose 75 happiness units by sitting next to Frank.
Mallory would lose 99 happiness units by sitting next to George.'.split("\n")

TEST1 = 'Alice would gain 54 happiness units by sitting next to Bob.
Alice would lose 79 happiness units by sitting next to Carol.
Alice would lose 2 happiness units by sitting next to David.
Bob would gain 83 happiness units by sitting next to Alice.
Bob would lose 7 happiness units by sitting next to Carol.
Bob would lose 63 happiness units by sitting next to David.
Carol would lose 62 happiness units by sitting next to Alice.
Carol would gain 60 happiness units by sitting next to Bob.
Carol would gain 55 happiness units by sitting next to David.
David would gain 46 happiness units by sitting next to Alice.
David would lose 7 happiness units by sitting next to Bob.
David would gain 41 happiness units by sitting next to Carol.'.split("\n")

puts calc_greatest_happiness_with_self(INPUT)