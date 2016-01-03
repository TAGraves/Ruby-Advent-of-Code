

def password_works(password)
  if password.match(/abc|bcd|cde|def|efg|fgh|ghi|hij|ijk|jkl|klm|lmn|mno|nop|opq|pqr|qrs|rst|stu|tuv|uvw|vwx|wxy|xyz/) && !password.match(/[iol]/) && password.match(/([a-z])\1(.)*([a-z])\3/)
    return true
  else
    return false
  end
end

$letters = "abcdefghijklmnopqrstuvwxyza"

def next_string(s)
  if s[-1] != 'z'
    s[-1] = $letters[$letters.index(s[-1]) + 1]
  else 
    z = s.match(/z*$/).to_s.length
    i = 0
    while i < z
      i += 1
      puts s
      s[-(i + 1)] = $letters[$letters.index(s[-(i + 1)])+1]
      s[-i] = "a"
    end
  end
  return s
end

def next_password(password)
  next_password = next_string(password)
  next_password = next_string(next_password) while !password_works(next_password)
  return next_password
end

TEST1 = "hijklmmn"
TEST2 = "abbceffg"
TEST3 = "abbcegjk"
TEST4 = "abcdefgh"
TEST5 = "abcdffaa"

INPUT = "cqjxjnds"

puts next_password(next_password(INPUT))

#puts password_works(TEST1)
#puts password_works(TEST2)
#puts password_works(TEST3)
#puts password_works(TEST4)
#puts password_works(TEST5)