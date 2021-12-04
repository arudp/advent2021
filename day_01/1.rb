lines = [199,200,208,210,200,207,240,269,260,263]


prev = nil
acc = 0

lines.each do |l|
  if prev and l > prev
    acc += 1
  end
  prev = l
end

puts acc
