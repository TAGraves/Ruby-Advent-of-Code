def try_containers(containers)
  containers.map! {|val| val.to_i }
  count = 0
  containers.length.times do |i|
    combos = containers.combination(i+1).to_a.each do |combo|
      sum = combo.inject(:+)
      if sum == 150
        count += 1
      end
    end
    ##Part 2 here
    if count > 0
      return count
    end
    ##End Part 2
  end
  #return count ##Part 1
end

CONTAINERS = "11
30
47
31
32
36
3
1
5
3
32
36
15
11
46
26
28
1
19
3".split("\n")

puts try_containers(CONTAINERS)
