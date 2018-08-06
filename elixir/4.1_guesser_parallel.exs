# I'm thinking of a number between 1 and 1000
defmodule Chop do
  def guess(secret, range) do  
    range_list = range_splitter(range)
    Enum.map range_list, &IO.inspect(&1)
    Enum.map range_list, &check(secret, &1)
  end

  def range_splitter(a..b) when a == b, do: [a..a]
  def range_splitter(a..b) do
    m = div(b-a, 4)
    [a..a+m, a+m+1..a+2*m, a+2*m+1..a+3*m, a+3*m+1..b]
  end

  defp check(secret, secret.._), do: IO.puts "It's #{secret}!! a"
  defp check(secret, _..secret), do: IO.puts "It's #{secret}!! b"
  
  defp check(secret, a..b) when (a < secret and secret < b) do
    IO.puts "Is it between #{a} and #{b}. Keep going!"
    range_list = range_splitter(a..b)
    Enum.map range_list, &IO.inspect(&1)
    Enum.map range_list, &check(secret, &1)
  end
  defp check(_, range) do
    IO.puts "Not between #{range.first} and #{range.last}... :("
  end

end

#Chop.guess(1, 1..1)
#Chop.guess(2, 1..9)
Chop.guess(273, 0..1000)