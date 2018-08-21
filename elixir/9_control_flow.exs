# if and unless
IO.puts if :atom == "atom", do: "verdade", else: "mentira"
IO.puts if :atom == :atom,  do: "verdade", else: "mentira"


IO.puts "\n~~~ FizzBuzz Bonanza"
defmodule FizzBuzz do
  def using_cond(n) when n > 0, do: _cond_version(n, [])

  defp _cond_version(0, result), do: result
  defp _cond_version(current, result) do
    value = cond do
      rem(current, 3) == 0 and rem(current, 5) == 0 ->
        "FizzBuzz"
      rem(current, 3) == 0 ->
        "Fizz"
      rem(current, 5) == 0 ->
        "Buzz"
      true ->
        current
    end
    _cond_version(current-1, [value | result])
  end

  # ---

  def using_map(n) when n > 0 do
    1..n |> Enum.map(&_map_version(&1))
  end

  defp _map_version(number) do
    cond do
      rem(number, 3) == 0 and rem(number, 5) == 0 ->
        "FizzBuzz"
      rem(number, 3) == 0 ->
        "Fizz"
      rem(number, 5) == 0 ->
        "Buzz"
      true ->
        number
    end
  end

  # ---

  def using_patt_match(n) when n > 0 do
    1..n |> Enum.map(&_pm_version/1)
  end

  defp _pm_version(n), do: _pm_version(rem(n,3), rem(n,5), n)
  defp _pm_version(0, 0, _), do: "FizzBuzz"
  defp _pm_version(0, _, _), do: "Fizz"
  defp _pm_version(_, 0, _), do: "Buzz"
  defp _pm_version(_, _, n), do: n

  # ---

  def using_case(n) when n > 0 do
    1..n |> Enum.map(&_case_version/1)
  end

  defp _case_version(number) do
    case number do
      n when rem(n, 15) == 0 -> "FizzBuzz"
      n when rem(n, 3)  == 0 -> "Fizz"
      n when rem(n, 5)  == 0 -> "Buzz"
      n -> n
    end
  end
end

IO.inspect FizzBuzz.using_cond(21)
IO.inspect FizzBuzz.using_map(21)
IO.inspect FizzBuzz.using_patt_match(21)
IO.inspect FizzBuzz.using_case(21)


# Case
IO.puts "\n~~~ Case"
case File.open("8.1_sales.csv") do
  {:ok, file}   -> IO.puts "Oká! 1st line = #{IO.read file, :line}"
  {:error, msg} -> IO.puts "Deu ruim => #{msg}"
end

defmodule User do
  dave = %{ name: "Dave", likes: "progrraming", age: 39, state: "TX"}

  case dave do
    %{state: some_state} = person -> IO.puts "#{person.name} lives in #{some_state}"
    %{age: some_age} = person     -> IO.puts "#{person.name} has #{some_age}"
    _ -> IO.puts "nothing found"
  end

  case dave do
    person = %{age: age} when is_number(age) and age >= 21 ->
      IO.puts "#{person.name} é grande o suficiente, parabéns"
    _ -> IO.puts "Sorry kiddo"
  end
end



# Ex 3
IO.puts ""
defmodule O do
  def k!(tuple) do
    case tuple do
      {:ok, data} -> data
      _ -> raise RuntimeError, message: "Algo não funcionou, amigo. Exercício 3"
    end
  end
end

# file = O.k! File.open("bozo")
file = O.k! File.open("passwd.sample")
IO.inspect file