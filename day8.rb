INPUT = File.read("./day8input.txt").gsub(" ", "").split("\n")

def parse_code(code)
  return code.length
end

def parse_string(code)
  return code.gsub(/\\x[a-fA-F\d]{2}/, "X").gsub(/\\"/, "X").gsub(/\\\\/, "X")[1...-1].length
end

def encode_string(code)
  return ('"' + code.gsub(/\\/, "\\\\\\").gsub(/"/, '\\"') + '"').length
end


def total_code(input)
  total = 0
  input.each do |code|
    total += parse_code(code)
  end
  return total
end

def total_string(input)
  total = 0
  input.each do |code|
    total += parse_string(code)
  end
  return total
end

def total_encode(input)
  total = 0
  input.each do |code|
    total += encode_string(code)
  end
  return total
end

def calc_difference(input)
  return total_code(input) - total_string(input)
end

def calc_encoded_difference(input)
  return total_encode(input) - total_code(input)
end




#puts calc_difference(INPUT)
puts calc_encoded_difference(INPUT)

TEST1 = '""'
TEST2 = '"abc"'
TEST3 = '"aaa\"aaa"'
TEST4 = '"\x27"'

=begin
puts parse_code(TEST1)
puts parse_string(TEST1)
puts parse_code(TEST2)
puts parse_string(TEST2)
puts parse_code(TEST3)
puts parse_string(TEST3)
puts parse_code(TEST4)
puts parse_string(TEST4)
puts calc_difference([TEST1, TEST2, TEST3, TEST4])
=end

puts calc_encoded_difference([TEST1, TEST2, TEST3, TEST4])