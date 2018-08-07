defmodule Squarer do
  def exec([]), do: []
  def exec([head | tail]), do: [ head * head | exec(tail) ]
end

IO.inspect Squarer.exec [2, 5, 6]

# Map implementation
defmodule Mapper do
  def map([], _func), do: []
  def map([head | tail], func), do: [ func.(head) | map(tail, func) ]
end

IO.inspect Mapper.map [900, 180, 370], fn(n) -> div(n,10) end
IO.inspect Mapper.map [900, 180, 370], &(div(&1, 10))
IO.inspect Mapper.map [900, 180, 370], &(&1 > 250)


# Sum implementation
defmodule Inject do
  def sum(list), do: _sum(list, 0)

  defp _sum([], total), do: total
  defp _sum([ head | tail], total), do: _sum(tail, head + total)

  # sum without an accumulator
  def sum2([]),                        do: 0
  def sum2([unique]),                  do: unique
  def sum2([first, last]),             do: sum2([first + last])
  def sum2([first | [second | tail]]), do: sum2([first + second | tail])
end

IO.puts Inject.sum [8,8,8,9]
# IO.puts Inject.sum2 [8,8,8,9]
IO.puts Inject.sum2 []
IO.puts Inject.sum2 [3]
IO.puts Inject.sum2 [3, 7, 8]
IO.puts Inject.sum2 [1, 2, 3, 5, 6, 7]

# Reduce implementation
defmodule Reduce do
  def exec([], value, _), do: value
  def exec([head | tail], value, func) do
    exec(tail, func.(head, value), func)
  end

  # Implement a maxsum
  def mapsum(list, func), do: _mapsum(list, 0, func)

  defp _mapsum([], total, _), do: total
  defp _mapsum([ head | tail], total, func) do
    _mapsum(tail, func.(head) + total, func)
  end
end

IO.inspect Reduce.exec([1,2,3,4,5], 0, &(&1 + &2))
IO.inspect Reduce.exec([1,2,3,4,5], 1, &(&1 * &2))   # same as below
IO.inspect  List.foldl([1,2,3,4,5], 1, &(&1 * &2))   # same as above
IO.inspect  List.foldr([1,2,3,4,5], 3, &(&1 * &2))   # same as above
IO.inspect Reduce.exec([1,2,3,4,5], 'acc', &("#{&1} - #{&2}"))

IO.inspect Reduce.mapsum([1,2,3], &(&1 * &1))


# max(list) = maximum value
defmodule Max do
  def find(list), do: _find(list, 0)

  def _find([], max), do: max
  def _find([head | tail], max) when head > max do
    _find(tail, head)
  end
  def _find([_head | tail], max) do
    _find(tail, max)
  end
end

IO.puts "Max.find([]) => #{Max.find([])}"
IO.puts "Max.find([0]) => #{Max.find([0])}"
IO.puts "Max.find([3]) => #{Max.find([3])}"
IO.puts "Max.find([3, 9]) => #{Max.find([3, 9])}"
IO.puts "Max.find([9, 3]) => #{Max.find([9, 3])}"
IO.puts "Max.find([9, 3, 27, 39, 1982348, 2]) => #{Max.find([9, 3, 27, 39, 1982348, 2])}"


# Ceasar cypher (only works for positive n...)
defmodule Encode do
  @a_code 96
  @z_code 122
  def ceasar([], _), do: []
  def ceasar([head | tail], n) when (head + n) > @z_code do
    [ rem(head + n, @z_code) + @a_code | ceasar(tail, n)]
  end
  def ceasar([head | tail], n) do
    [ head + n | ceasar(tail, n)]
  end
end

IO.puts Encode.ceasar('ryvkve', 13)
IO.puts Encode.ceasar('elixir', -13)



# MyList.span(from, to) - returns list of number from..to
defmodule MyList do
  def span(from, to), do: _span(from..to, [])

  defp _span(from..from, list), do: [from | list]
  defp _span(from..to,   list) when from < to do
    _span(from..(to-1), [to | list])
  end
  defp _span(from..to,   list) when from > to do
    _span(from..(to+1), [to | list])
  end
end

IO.inspect MyList.span(2, 2)
IO.inspect MyList.span(2, -3)
IO.inspect MyList.span(2, 8)
IO.inspect MyList.span(-8, 2)