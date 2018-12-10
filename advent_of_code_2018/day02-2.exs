defmodule Day02 do

  def closest(list) when is_list(list) do
    list
      |> Enum.map(&String.to_charlist/1)
      |> find_closest_charlist()
  end

  def find_closest_charlist([head | tail]) do
    Enum.find_value(tail, &one_char_diff(&1, head)) ||
      find_closest_charlist(tail)
  end

  def one_char_diff(word1, word2) do
    one_char_diff(word1, word2, [], 0)
  end

  def one_char_diff([head | tail1], [head | tail2], list_of_equals, difference_count) do
    one_char_diff(tail1, tail2, [head | list_of_equals], difference_count)
  end

  def one_char_diff([_ | tail1], [_ | tail2], list_of_equals, difference_count) do
    one_char_diff(tail1, tail2, list_of_equals, difference_count + 1)
  end

  def one_char_diff([], [], list_of_equals, 1) do
    list_of_equals |> Enum.reverse() |> List.to_string()
  end

  def one_char_diff([], [], _, _) do
    nil
  end


end

case System.argv() do
  [file_input] ->
    file_input
      |> File.read!
      |> String.split("\n", trim: true)
      |> Day02.closest
      |> IO.puts

  _ ->
    IO.puts "==> Running tests | for a file input, try `elixir file.exs [input_name]`"
    ExUnit.start(trace: true)

    defmodule Day02Test do
      use ExUnit.Case

      test 'one_char_diff' do
        assert Day02.one_char_diff('abcde', 'axcye') == nil
        assert Day02.one_char_diff('fghij', 'fguij') == "fgij"
      end

      # Of these box IDs, four of them contain a letter which appears exactly twice,
      # and three of them contain a letter which appears exactly three times.
      # Multiplying these together produces a checksum of 4 * 3 = 12.
      test 'example given' do
        input = [
          "abcde",
          "fghij",
          "klmno",
          "pqrst",
          "fguij",
          "axcye",
          "wvxyz"
        ]
        assert Day02.closest(input) == "fgij"
      end
    end

end
