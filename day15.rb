def parse_input(input)
  ingredients = {}
  input.each do |line|
    matcher = line.match(/(\w+): capacity (-?\d+), durability (-?\d+), flavor (-?\d+), texture (-?\d+), calories (-?\d+)/)
    ingredient = {"name" => matcher[1], "capacity" => matcher[2].to_i, "durability" => matcher[3].to_i, "flavor" => matcher[4].to_i, "texture" => matcher[5].to_i, "calories" => matcher[6].to_i}
    ingredients[matcher[1]] = ingredient
  end
  return ingredients
end

def calculate_total(ingredients, permutation)
  capacity = 0
  durability = 0
  flavor = 0
  texture = 0
  ingredients.each do |name, ingredient|
    multiplier = permutation[name]
    capacity += multiplier * ingredient['capacity']
    durability += multiplier * ingredient['durability']
    flavor += multiplier * ingredient['flavor']
    texture += multiplier * ingredient['texture']
  end
  case true
  when capacity < 0 
    capacity = 0
  when durability < 0
    durability = 0
  when flavor < 0
    flavor = 0
  when texture < 0
    texture = 0
  end
  total = capacity * durability * flavor * texture
  return total
end

def get_permutations(ingredients)
  keys = ingredients.keys
  permutations = []
  100.times do |i|
    ing = {}
    ing[keys[0]] = i
    next_permutation(ing, keys, 1, 100-i, permutations)
  end
  return permutations
end

def next_permutation(ingredients, keys, level, amount, permutations)
  ing = ingredients.clone
  if level+1 == keys.length
    ing[keys[level]] = amount
    permutations.push(ing)
  else
    amount.times do |i|
      ing[keys[level]] = i
      next_permutation(ing, keys, level+1, amount-i, permutations)
    end
  end
end

def find_best_cookie(input)
  ingredients = parse_input(input)
  permutations = get_permutations(ingredients)
  best = 0
  bestP = {}
  permutations.each do |permutation|
    total = calculate_total(ingredients, permutation)
    
    if total > best
      best = total
      bestP = permutation
    end
  end
  return best
end

INPUT = "Sugar: capacity 3, durability 0, flavor 0, texture -3, calories 2
Sprinkles: capacity -3, durability 3, flavor 0, texture 0, calories 9
Candy: capacity -1, durability 0, flavor 4, texture 0, calories 1
Chocolate: capacity 0, durability 0, flavor -2, texture 2, calories 8".split("\n")

TEST1 = "Butterscotch: capacity -1, durability -2, flavor 6, texture 3, calories 8
Cinnamon: capacity 2, durability 3, flavor -2, texture -1, calories 3".split("\n")

puts find_best_cookie(INPUT)