INPUT = "./day_01/input"
SMALL_INPUT = "./day_01/small_input"

class Window

  attr_writer :on_full
  attr_reader :values
  @@max_length = 3

  def initialize
    @on_full = nil
    @values = []
  end

  def add(value)
    @values << value

    if full?
      @on_full.call
    end
  end

  def full?
    @values.length >= @@max_length
  end

end

windows = []
$acc = 0


def run_window_comparison(curr, prev)
  if prev && curr.values.inject(:+) > prev.values.inject(:+)
    $acc += 1
    puts "On #{curr.values.inject(:+)}"
  end
end

File.open(INPUT, "r") do |f|
  f.each_line do |line|
    prev_2 = windows[-2]
    prev_1 = windows[-1]

    current = Window.new
    current.on_full = lambda { run_window_comparison(current, prev_1) }

    [prev_2, prev_1, current].each { |window| window.add(Integer(line)) if window }

    windows << current
  end
end

puts $acc
