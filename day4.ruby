require 'digest'

INPUT = "ckczppom"

def checkMD5Hash(input)
  md5 = Digest::MD5.hexdigest(input)
  if md5[0..4] == "00000"
    return true
  else
    return false
  end
end

def mine(secret)
  answer = 0
  while !checkMD5Hash(secret + answer.to_s)
    answer += 1
  end
  return answer
end

puts mine(INPUT)

#TEST1 = "abcdef"
#TEST2 = "pqrstuv"

#puts mine(TEST1)
#puts mine(TEST2)