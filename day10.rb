def look_and_see(num)
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
  i = 0
  while i < iterations do
    input = look_and_see(input)
    i += 1
  end
  return input
end

INPUT = 1113222113

TEST1 = 1

puts iterate_looks(INPUT, 40).length
