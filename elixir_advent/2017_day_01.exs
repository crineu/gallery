# --- Day 1: Inverse Captcha ---
#
# The captcha requires you to review a sequence of digits (your puzzle input) and find the sum of all digits that match the next digit in the list. The list is circular, so the digit after the last digit is the first digit in the list.

defmodule Day01 do

  def captcha([]),  do: 0
  def captcha([_]), do: 0
  def captcha(list) do
    sum(list, List.last(list), 0)
  end

  defp sum([a], a, total), do: total + ascii_digit_to_number(a)
  defp sum([_], _, total), do: total
  defp sum([a | tail], a, total), do: sum(tail, a, total + ascii_digit_to_number(a))
  defp sum([a | tail], _, total), do: sum(tail, a, total)

  defp ascii_digit_to_number(digit), do: digit - ?0

end

ExUnit.start()


# 1122 produces 3 (1 + 2) because the first digit (1) matches the second digit and the third digit (2) matches the fourth digit.
# 1111 produces 4 because each digit (all 1) matches the next.
# 1234 produces 0 because no digit matches the next.
# 91212129 produces 9 because the only digit that matches the next one is the last digit, 9.

defmodule Day01Test do
  use ExUnit.Case

  test "special cases" do
    assert Day01.captcha('') == 0
    assert Day01.captcha('1') == 0
  end

  test "regular cases" do
    assert Day01.captcha('1122') == 3
    assert Day01.captcha('1111') == 4
    assert Day01.captcha('1234') == 0
    assert Day01.captcha('91212129') == 9
  end
end