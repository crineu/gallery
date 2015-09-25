
$SWITCHES = Array.new((1000)) { |i| i = false  }

def count_off
  turned_off = 0
  $SWITCHES.each { |switch| turned_off += 1 unless switch  }
  turned_off
end

puts "number off = " + count_off.to_s

0.upto(999) do |st|
  st.step(1000, st + 1) do |index|
    $SWITCHES[index] = !$SWITCHES[index]
  end
end

puts "number off = " + count_off.to_s
