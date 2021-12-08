INPUT = "./day_02/input"
SMALL_INPUT = "./day_02/small_input"

def get_most_common(filtered, pos)
  ones = filtered.reduce(0) { |sum, line| sum + Integer(line[pos]) }
  return ones >= len(filtered) / 2 ? "1" : "0"
end

lines = File.readlines(INPUT)

length = lines[0].length
filtered = lines
pos = 0

while filtered.length > 1 && pos < length
  common = get_most_common(filtered, pos)
  filtered = filtered.filter { |line| line[pos] == common }
  pos += 1
end

oxygen = filtered[0]

filtered = lines
pos = 0

while filtered.length > 1 && pos < length
  common = get_most_common(filtered, pos)
  common = common == "0" ? "1" : "0"

  filtered = filtered.filter { |line| line[pos] == common }
  pos += 1
end

co2 = filtered[0]

puts "Oxygen: #{oxygen}"
puts "CO2: #{co2}"
