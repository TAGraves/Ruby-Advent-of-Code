def make_place_map(placeHash)
  placeMap = []
  placeHash.each_key do |key|
    placeMap.push(key)
  end
  return placeMap
end

def make_place_hash(data)
  placeHash = {}
  data.each do |direction|
    splitter = direction.gsub(" ", "").split("=")[0].split("to")
    start = splitter[0]
    finish = splitter [1]
    distance = direction.split("= ")[1].to_i
    if !placeHash.has_key?(start)
      placeHash[start] = {}
    end
    
    if !placeHash.has_key?(finish)
      placeHash[finish] = {}
    end
    placeHash[start][finish] = distance
    placeHash[finish][start] = distance
  end
  return placeHash
end

def calc_shortest_route(data)
  distances = make_place_hash(data)
  places = make_place_map(distances)
  shortest_route = 0
  routes = get_permutations(places)
  routes.each do |route|
    i = 0
    routeLength = 0
    while i < route.length-1 do
      routeLength += distances[route[i]][route[i+1]]
      i += 1
    end
    if shortest_route == 0 || routeLength < shortest_route
      shortest_route = routeLength
    end
  end
  return shortest_route
end

def calc_longest_route(data)
  distances = make_place_hash(data)
  places = make_place_map(distances)
  longest_route = 0
  routes = get_permutations(places)
  routes.each do |route|
    i = 0
    routeLength = 0
    while i < route.length-1 do
      routeLength += distances[route[i]][route[i+1]]
      i += 1
    end
    if routeLength > longest_route
      longest_route = routeLength
    end
  end
  return longest_route
end

def get_permutations(places)
  routes = []
  i = 0
  while i < places.length
    route = [places[i]]
    next_permutation(places, 1, routes, route)
    i += 1
  end
  return routes
end

def next_permutation(places, level, routes, route)
  i = 0
  if level < places.length
    while i < places.length
      if !route.include?(places[i])
        permutationRoute = route.clone
        permutationRoute.push(places[i])
        next_permutation(places, level+1, routes, permutationRoute)
      end
      i += 1
    end
  else
    routes.push(route)
  end
end

INPUT = ("AlphaCentauri to Snowdin = 66
AlphaCentauri to Tambi = 28
AlphaCentauri to Faerun = 60
AlphaCentauri to Norrath = 34
AlphaCentauri to Straylight = 34
AlphaCentauri to Tristram = 3
AlphaCentauri to Arbre = 108
Snowdin to Tambi = 22
Snowdin to Faerun = 12
Snowdin to Norrath = 91
Snowdin to Straylight = 121
Snowdin to Tristram = 111
Snowdin to Arbre = 71
Tambi to Faerun = 39
Tambi to Norrath = 113
Tambi to Straylight = 130
Tambi to Tristram = 35
Tambi to Arbre = 40
Faerun to Norrath = 63
Faerun to Straylight = 21
Faerun to Tristram = 57
Faerun to Arbre = 83
Norrath to Straylight = 9
Norrath to Tristram = 50
Norrath to Arbre = 60
Straylight to Tristram = 27
Straylight to Arbre = 81
Tristram to Arbre = 90").split("\n")
  
TEST1 = ("London to Dublin = 464
London to Belfast = 518
Dublin to Belfast = 141").split("\n")

puts calc_longest_route(INPUT)