def look_and_say(num)
  numString = num.to_s
  lastNum = ""
  output = ""
  i = 0
  while i < numString.length do
    someNum = numString[i]
    if someNum != lastNum
      lastNum = someNum
      count = 1
      e = i+1
      while e < numString.length do
        nextNum = numString[e]
        if nextNum == someNum
          count += 1
          e += 1 
        else
          e = numString.length
        end
      end
      output += count.to_s + someNum
    end
    i += 1
  end
  return output
end

def iterate_looks(input, iterations)
  iterations.times do |i|
    input = look_and_say(input)
    print i
    print ": "
    print input.length
    print "\n"
  end
  return input
end

INPUT = 1113222113

TEST1 = 1

puts iterate_looks(INPUT, 50).length
