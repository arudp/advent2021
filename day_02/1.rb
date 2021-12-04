INPUT = "./day_02/input"
SMALL_INPUT = "./day_02/small_input"

:forward
:down
:up

class Position

  attr_reader :depth, :horizontal

  def initialize
    @depth = 0
    @horizontal = 0
  end

  def move(direction, quantity)
    case direction
    when :forward
      @horizontal += quantity
    when :down
      @depth += quantity
    when :up
      @depth -= quantity
    end
  end
end


def main
  position = Position.new

  File.open(INPUT, "r") do |f|
    f.each_line do |line|
      direction, quantity = line.split(" ")
      position.move(direction.to_sym, quantity.to_i)
    end
  end

  puts "#{position.depth} * #{position.horizontal} = #{position.depth * position.horizontal}"
end

main
