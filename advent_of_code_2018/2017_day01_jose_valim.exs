# Run it with: elixir advent_of_code_2017_day_1.exs
# https://adventofcode.com/2017/day/1
defmodule Exercise1 do
  def captcha([]), do: 0
  def captcha([_]), do: 0
  def captcha(list), do: sum_equal(list, List.last(list), 0)

  defp sum_equal([current | list], previous, acc) when current == previous do
    sum_equal(list, current, acc + ascii_digit_to_number(current))
  end

  defp sum_equal([current | list], _previous, acc) do
    sum_equal(list, current, acc)
  end

  defp sum_equal([], _previous, acc) do
    acc
  end

  defp ascii_digit_to_number(digit), do: digit - ?0
end

ExUnit.start()

defmodule Exercise1Test do
  use ExUnit.Case

  import Exercise1

  test "special cases" do
    assert captcha('') == 0
    assert captcha('1') == 0
  end

  test "regular cases" do
    assert captcha('1122') == 3
    assert captcha('1111') == 4
    assert captcha('1234') == 0
    assert captcha('91212129') == 9
  end
end
