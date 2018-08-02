# IEX tips
# h Enum.reverse/1          # help
# i 123                     # inspect
# i Map

IO.puts "IO.puts for puts"

# Pattern Matching
[a, b, a] = [4, 3, 4]

# TYPES
list1 = [3, 5, 2]   # List
list2 = [4 | list1]

IO.puts 2983    # Integer
IO.puts 923.3   # Float
IO.puts :atom   # Atom
2..5            # Ranges
{ 1, 2 }    # Tuples
{ :ok, 42 }
[ name: "bozo", city: "Dallas" ]  # Keyword list


# STRINGS

'Jósẽ' == "Jósẽ"  # false!
# List_of_char != BitString


# MAPS
colors = %{ red: 0xff0000, gren: 0x00ff00, blue: 0x0000ff }
IO.puts "calling colors.blue = #{colors.blue}"


# REGEX
IO.puts Regex.run     ~r{[aeiou]}, "caterpillar"
IO.puts Regex.scan    ~r{[aeiou]}, "caterpillar"
IO.puts Regex.split   ~r{[aeiou]}, "caterpillar"
IO.puts Regex.replace ~r{[aeiou]}, "caterpillar", "&"


# BINARIES
bin = << 1, 2>>
IO.puts "<<1, 2>> byte_size #{byte_size bin}"
bin = <<3 :: size(2), 5 :: size(4), 1 :: size(2) >>
IO.puts :io.format("~-8.2b~n", :binary.bin_to_list(bin))
IO.puts "<<3 :: size(2), 5 :: size(4), 1 :: size(2) >> = #{byte_size bin}"

# DATES
d1 = Date.new(2016, 12, 25)
{:ok, d1} = Date.new(2016, 12, 25)
IO.puts inspect d1, structs: false

{:ok, t1} = Time.new(12, 34, 56)
IO.puts inspect t1, structs: false


# OPERATORS
[a, b] = [1, 1.0]

IO.puts "a === b  eq  #{a === b}    # strict equality"
IO.puts "a !== b  eq  #{a !== b}     # strict inequality"
IO.puts "a ==  b  eq  #{a ==  b}     # value equality"
IO.puts "a !=  b  eq  #{a !=  b}    # value inequality"
IO.puts "a >  b   eq  #{a >  b}    # normal comparison"
IO.puts "a >= b   eq  #{a >= b}     # normal comparison"
IO.puts "a <  b   eq  #{a <  b}    # normal comparison"
IO.puts "a <= b   eq  #{a <= b}     # normal comparison"


# truthy: any value other than nil and :false are treated as :true
# BOOLEAN OPERATORS
IO.puts "a or b     # true if a is true, otherwise b"
IO.puts "a and b    # false if a is false, otherwise b"
IO.puts "not a      # fasle if a is true, true otherwise"

# RELAXED BOOLEANS
IO.puts "a || b     # a if a is truthy, otherwise b"
IO.puts "a && b     # b if a is truthy, otherwise b"
IO.puts "!a         # false if a is truthy, otherwise b"


# ARITHMETIC OPERATORS
IO.puts "7 / 3     = #{8 / 3}"
IO.puts "div(7, 3) = #{div(7, 3)}"
IO.puts "rem(7, 3) = #{rem(7, 3)}"
