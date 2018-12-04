# --- Day 1: Inverse Captcha ---
#
#... you need to find the first frequency it reaches twice.
# ...using the same list of changes above, the device would loop as follows:
#
#    Current frequency  0, change of +1; resulting frequency  1.
#    Current frequency  1, change of -2; resulting frequency -1.
#    Current frequency -1, change of +3; resulting frequency  2.
#    Current frequency  2, change of +1; resulting frequency  3.
#    (At this point, the device continues from the start of the list.)
#    Current frequency  3, change of +1; resulting frequency  4.
#    Current frequency  4, change of -2; resulting frequency  2, which has already been seen.
#
#  In this example, the first frequency reached twice is 2.


defmodule Day01 do

  def repeated_frequency(file_stream) do
    file_stream
      |> Stream.map(fn line ->
        {integer, _leftover} = Integer.parse(line)
        integer
      end)
      |> Stream.cycle()
      |> Enum.reduce_while({0, MapSet.new([0])}, fn x, {current_frequency, seen_frequency} ->
        new_frequency = current_frequency + x

        if new_frequency in seen_frequency do
          {:halt, new_frequency}
        else
          {:cont, {new_frequency, MapSet.put(seen_frequency, new_frequency)}}
        end
      end)
  end

end


case System.argv() do
  [file_name] ->
    file_name
      |> File.stream!([], :line)
      |> Day01.repeated_frequency
      |> IO.puts

  _ ->
    IO.puts "==> Running tests | for a file input, try `elixir file.exs [input_name]`"
    ExUnit.start(trace: true)

    defmodule Day01Test do
      use ExUnit.Case

      test "1st example given" do
        assert Day01.repeated_frequency([
          "+1\n",
          "-1\n"
        ]) == 0
      end

      test "2nd example given" do
        assert Day01.repeated_frequency([
          "+3\n",
          "+3\n",
          "+4\n",
          "-2\n",
          "-4\n"
        ]) == 10
      end

      test "3rd example given" do
        assert Day01.repeated_frequency([
          "-6\n",
          "+3\n",
          "+8\n",
          "+5\n",
          "-6\n"
        ]) == 5
      end

      test "4th example given" do
        assert Day01.repeated_frequency([
          "+7\n",
          "+7\n",
          "-2\n",
          "-7\n",
          "-4\n"
        ]) == 14
      end
    end

end
