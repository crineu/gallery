# I'm thinking of a number between 1 and 1000
defmodule Chop do
  def range_spliter(a..a), do: [a..a]
  def range_spliter(a..b), do: [a..div(a+b, 2), div(a+b, 2)+1..b]

  def guess(secret, a..b) when (a < secret and secret < b) do
    IO.puts "Is it between #{a} and #{b}. Keep going!"
    a..b
      |> range_spliter
      |> Enum.map(&IO.inspect(&1))
      |> Enum.map(&guess(secret, &1))
  end

  def guess(secret, secret.._), do: IO.puts "It's #{secret}!! a"
  def guess(secret, _..secret), do: IO.puts "It's #{secret}!! b"
  def guess(_, a..b) do
    IO.puts "Not between #{a} and #{b}... :("
  end

end

# Chop.guess(1, 1..1)
# Chop.guess(3, 1..19)
Chop.guess(273, 0..1000)