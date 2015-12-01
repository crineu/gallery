# In Ruby, every method will accept a block as its last argument.
 # It’s also the case that you can omit the block argument from Enumerable
  # methods to get back an Enumerator that allows iteration.
enumerator = [3, 2, 1].each
puts enumerator.next #=> 3
puts enumerator.peek #=> 2
enumerator.rewind


# For finite enumerators, Ruby will raise a StopIteration exception if you ask
 # for the next object, beyond the last.
# However, this exception is automatically rescued by loop:
loop do
  puts enumerator.next
end
puts "Blastoff!"


# Ruby also allows infinite enumerators. This can be a useful structure for
 # representing data streams, musical notes in a game, or the background
 # color for rows in a table:
infinite_zebra = ["black", "white"].cycle
puts infinite_zebra.next #=> "black"
puts infinite_zebra.next #=> "white"
puts infinite_zebra.next #=> "black"


puts RUBY_VERSION

# Since version 2, Ruby supports lazy enumerators. So, if you wanted to find
# the first five even, perfect squares over a thousand, you could write:
lazy_integers = (1..Float::INFINITY).lazy
print lazy_integers.collect { |x| x ** 2 }.
            select  { |x| x.even? }.
            reject  { |x| x < 1000 }.
            first(5)
#=> [1024, 1156, 1296, 1444, 1600]


# Likewise, if you wanted to find the first five twin primes, you could write:
require "prime"
lazy_primes = Prime.lazy
print lazy_primes.select  { |x| (x - 2).prime? }.
            collect { |x| [x - 2, x] }.
            first(5)
# #=> [[3, 5], [5, 7], [11, 13], [17, 19], [29, 31]]

# Or if you wanted to find the next ten Friday the 13ths, you could write:
require "date"
lazy_dates = (Date.today..Date.new(9999)).lazy
puts lazy_dates.select { |d| d.friday? && d.day == 13 }.
           first(10)

# Or if you wanted to find a string in a text file without reading the entire file into memory:
# lazy_file = File.readlines("/path/to/file").lazy
# lazy_file.detect { |x| x =~ /regexp/ }
