# Enum methods

IO.inspect list = Enum.to_list 1..5

IO.inspect Enum.split(list, 3)
IO.inspect Enum.zip(list, list)
IO.inspect Enum.zip(list, [:a, :b, :c ])


IO.puts "Enum.reduce(1..100, &(&1 + &2)) = #{Enum.reduce(1..100, &(&1 + &2))}"

IO.puts Enum.reduce(["now", "it's", "the", "tiiiime", "on", "two"], fn word, longest ->
  if String.length(word) > String.length(longest) do
    word
  else
    longest
  end
end)


IO.puts "Deal a hand of cards"
IO.inspect deck = for rank <- '23456789TJQKA', suit <- 'CDHS', do: [suit, rank]
IO.inspect hand =  deck |> Enum.shuffle |> Enum.take(13)
IO.inspect hands = deck |> Enum.shuffle |> Enum.chunk_every(13)

# Implemente Enum funcs: all? each, filter, split, take
# Write a flatten method -> MyEnum.flatten([1, [2,3,[4]], 5, [[[6]]]]) = [1,2,3,4,5,6]
defmodule MyEnum do
  def all?(list, func) when is_list(list) do
    _all?(list, true, func)
  end
  defp _all?(_, false, _), do: false
  defp _all?([], true, _), do: true
  defp _all?([head | tail], true, func) do
    _all?(tail, func.(head), func)
  end

  def each([], _), do: :ok
  def each([head | tail], func) do
    func.(head)
    each(tail, func)
  end

  def take(list, qty), do: _take(list, [], qty)
  defp _take([], taken, _), do: Enum.reverse taken
  defp _take(_, taken, 0), do: Enum.reverse taken
  defp _take([head | tail], taken, qty) do
    _take(tail, [head | taken], qty-1)
  end

  def flatten(list), do: _flatten(list, [])
  defp _flatten([], flat), do: Enum.reverse flat
  defp _flatten([head | tail], flat) when is_list(head) do
    _flatten(head ++ tail, flat)
  end
  defp _flatten([head | tail], flat) do
    _flatten(tail, [head | flat])
  end
end

my_list = Enum.to_list 5..15
IO.puts MyEnum.all? my_list, &(&1 < 5)
IO.puts MyEnum.all? my_list, &(&1 > 15)
IO.puts MyEnum.all? my_list, &(&1 < 16)
IO.puts MyEnum.all? my_list, &(&1 > 4)

IO.inspect MyEnum.each [1,2,3], &IO.puts(&1)

IO.inspect MyEnum.take my_list, 99

IO.inspect MyEnum.flatten([1, [2,3,[4]], 5, [[[6]]]])


# Streams
IO.puts "\nSTREAMS !!"

IO.puts File.read!("/usr/share/dict/cracklib-small")
        |> String.split
        |> Enum.max_by(&String.length/1)

IO.puts File.open!("/usr/share/dict/cracklib-small")
        |> IO.stream(:line)
        |> Enum.max_by(&String.length/1)

IO.puts File.stream!("/usr/share/dict/cracklib-small")
        |> Enum.max_by(&String.length/1)

IO.inspect s = Stream.map [1,3,5,7], &(&1 + 1)
IO.inspect Enum.to_list s

# Eager vs lazy
# IO.inspect   Enum.map(1..20_000_000, &(&1+1)) |> Enum.take(5) # takes too long
IO.inspect Stream.map(1..20_000_000, &(&1+1)) |> Enum.take(5)

IO.inspect Stream.cycle([:on, :off]) |> Enum.zip(Enum.to_list(1..5))
IO.inspect Stream.repeatedly(&:random.uniform/0) |> Enum.take(3)
IO.inspect Stream.iterate(0, &(&1+1)) |> Enum.take(5)

# Fibonacci
IO.inspect Stream.unfold({0,1}, fn{a,b} -> {a, {b, a+b}} end) |> Enum.take(11)


# Comprehensions
IO.inspect for x <- [1,2,3,4,5], x < 4, do: x * x

IO.inspect min_max = [{1,4}, {2,4}, {10,15}]
IO.inspect for {min,max} <- min_max, n <- min..max, do: n
IO.inspect for {min,max} <- min_max, n <- min..max, into: [], do: n

IO.inspect for << ch <- "palavra" >>, do: <<ch>>

# Exercise
IO.puts "\n"

IO.inspect tax_rates = [ NC: 0.075, TX: 0.08 ]
IO.inspect orders = [
  [ id: 123, ship_to: :NC, net_amount: 100.00 ],
  [ id: 124, ship_to: :OK, net_amount:  35.50 ],
  [ id: 125, ship_to: :TX, net_amount:  24.00 ],
  [ id: 126, ship_to: :TX, net_amount:  44.80 ],
  [ id: 127, ship_to: :NC, net_amount:  25.00 ],
  [ id: 128, ship_to: :MA, net_amount:  10.00 ],
  [ id: 129, ship_to: :CA, net_amount: 102.00 ],
  [ id: 130, ship_to: :NC, net_amount:  50.00 ],
]

# function to return orders with tax_rate:
defmodule Tax do
  def fix_table(orders, rates) do
    for order <- orders, do: order ++ _total_amount(order[:net_amount], rates[order[:ship_to]])
  end

  defp _total_amount(net_amount, nil), do: [ total_amout: net_amount             ]
  defp _total_amount(net_amount, tax), do: [ total_amout: (net_amount * (1+tax)) ]
end

IO.inspect Tax.fix_table(orders, tax_rates)