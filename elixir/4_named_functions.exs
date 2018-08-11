defmodule Times do
  def double(n),    do: n * 2
  def triple(n),    do: n * 3
  def quadruple(n), do: double(n) * 2
end

IO.puts Times.double(11)
IO.puts Times.triple(11)
IO.puts Times.quadruple(11)


# Recursion
defmodule Fatorial do
  def of(0), do: 1
  def of(n) when n > 0 do
    n * of(n-1)
  end
end

IO.puts "Fatorial.of(7) #{Fatorial.of(7)}"
IO.puts "Fatorial.of(77) #{Fatorial.of(77)}"

defmodule Ex do
  def sum(1), do: 1
  def sum(n), do: n + sum(n - 1)

  def gcd(x, 0), do: x
  def gcd(x, y), do: gcd(y, rem(x,y))
end

IO.puts "Ex.sum(4) #{Ex.sum(4)}"
IO.puts "Ex.gcd(348, 138) #{Ex.gcd(348, 138)}"

# Default parameters
defmodule Example do
  def func(p1, p2 \\ 2, p3 \\ 3, p4) do
    IO.inspect [p1, p2, p3, p4]
  end
end

Example.func("primeiro", "segundo")
Example.func("primeiro", "segundo", "terceiro")
Example.func("primeiro", "segundo", "terceiro", "quarto")

# I'm thinking of a number between 1 and 1000
defmodule Chop do
  def guess(secret, a..b) do
    check(secret, div(a+b, 2), a..b)
  end

  defp check(secret, secret, _), do: IO.puts "That's #{secret}!!"
  defp check(secret, guess, a.._) when (secret < guess) do
    IO.puts "Is it #{guess}? No, it's lower..."
    check(secret, div(a+guess, 2), a..guess)
  end
  defp check(secret, guess, _..b) when (secret > guess) do
    IO.puts "Is it #{guess}? No, it's bigger..."
    check(secret, div(guess+b, 2), guess..b)
  end

end

Chop.guess(1, 1..1)
Chop.guess(2, 1..9)
Chop.guess(273, 0..1000)


# The amazing pipe operator
IO.inspect (1..10) |> Enum.map(&(&1 * &1)) |> Enum.filter(&(&1 < 40))
IO.inspect 1..10
    |> Enum.map(&(&1 * &1))
    |> Enum.filter(&(&1 < 40))


# Atributos de Modulos
defmodule ExampleAttribute do
  @author "Constante setada sem = que funciona como uma macro"
  def get_author do
    @author
  end
end

IO.puts ExampleAttribute.get_author


# Exercícios

# 1) converter float em string [Erlang]
IO.puts :erlang.float_to_binary(127.89334, decimals: 2)
IO.puts :erlang.float_to_binary(10/3, decimals: 3)

# 2) print value of OS env variable [Elixir]
IO.inspect System.get_env          # all
IO.inspect System.get_env("PWD")

# 3) Return the extension of a file name ('.exs' for '4_named_functions.exs') [Elixir]
IO.puts Path.extname("4_named_functions.exs")

# 4) Return the process's current working dir [Elixir]
IO.puts System.cwd

# 6) Execute a command in your OS shell
IO.inspect System.cmd("asdf", ["list", "ruby"])
