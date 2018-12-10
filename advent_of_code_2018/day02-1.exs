defmodule Day02 do

  def checksum(list) when is_list(list) do
    {twices, thrices} = list
      |> Enum.map(fn box_id ->
        box_id
          |> count_letters
          |> get_twice_and_thrice
      end)
      |> Enum.reduce({0, 0}, fn {twice, trice}, {total2, total3} ->
        {twice + total2, trice + total3}
      end)

    twices * thrices
  end

  def get_twice_and_thrice(count_map) when is_map(count_map) do
    Enum.reduce(count_map, {0, 0}, fn
      {_codepoint, 2}, {_twice, thrice} -> {1, thrice}
      {_codepoint, 3}, {twice, _thrice} -> {twice, 1}
      _, acc -> acc
    end)
  end

  def count_letters(line) when is_binary(line) do
    _count_letters(line, %{})
  end

  defp _count_letters(<<codepoint::utf8, rest::binary>>, acc) do
    acc = Map.update(acc, codepoint, 1, &(&1 + 1))
    _count_letters(rest, acc)
  end
  defp _count_letters(<<>>, acc), do: acc


end

case System.argv() do
  [file_input] ->
    file_input
      |> File.read!
      |> String.split("\n")
      |> Day02.checksum
      |> IO.puts

  _ ->
    IO.puts "==> Running tests | for a file input, try `elixir file.exs [input_name]`"
    ExUnit.start(trace: true)

    defmodule Day02Test do
      use ExUnit.Case

      test 'count_letters 1' do
        assert Day02.count_letters("bababéc") == %{
          ?a => 2,
          ?b => 3,
          ?é => 1,
          ?c => 1
        }
      end

      test 'count_letters 2' do
        assert Day02.count_letters("aabcdd") == %{
          ?a => 2,
          ?b => 1,
          ?c => 1,
          ?d => 2
        }

      end

      # Of these box IDs, four of them contain a letter which appears exactly twice,
      # and three of them contain a letter which appears exactly three times.
      # Multiplying these together produces a checksum of 4 * 3 = 12.
      test 'example given' do
        input = [
          "abcdef",
          "bababc",
          "abbcde",
          "abcccd",
          "aabcdd",
          "abcdee",
          "ababab"
        ]
        assert Day02.checksum(input) == 12
      end
    end

end
