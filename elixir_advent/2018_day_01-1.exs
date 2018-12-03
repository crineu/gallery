# --- Day 1: Inverse Captcha ---
#
# shows a sequence of changes in frequency (your puzzle input). A value like +6 means the current frequency increases by 6; a value like -3 means the current frequency decreases by 3.
#
# For example, if the device displays frequency changes of +1, -2, +3, +1, then starting from a frequency of zero, the following changes would occur:
#   Current frequency  0, change of +1; resulting frequency  1.
#   Current frequency  1, change of -2; resulting frequency -1.
#   Current frequency -1, change of +3; resulting frequency  2.
#   Current frequency  2, change of +1; resulting frequency  3.
# In this example, the resulting frequency is 3.

defmodule Day01 do
  def final_frequency(file_stream) do
    file_stream
      |> Stream.map(fn line ->
        {integer, _leftover} = Integer.parse(line)
        integer
      end)
      |> Enum.sum
  end
end

case System.argv() do
  ["--test"] ->
    ExUnit.start(trace: true)

    defmodule Day01Test do
      use ExUnit.Case

      test "1st example given" do
        {:ok, io} = StringIO.open("""
        +1
        +1
        +1
        """)
        assert Day01.final_frequency(IO.stream(io, :line)) == 3
      end

      test "2nd example given" do
        {:ok, io} = StringIO.open("""
        +1
        +1
        -2
        """)
        assert Day01.final_frequency(IO.stream(io, :line)) == 0
      end

      test "3rd example given" do
        {:ok, io} = StringIO.open("""
        -1
        -2
        -3
        """)
        assert Day01.final_frequency(IO.stream(io, :line)) == -6
      end
    end

  [file_name] ->
    file_name
      |> File.stream!([], :line)
      |> Day01.final_frequency
      |> IO.puts

  _ ->
    IO.puts :stderr, "we expect --test or a file_name; try `elixir 2018_day_01-1.exs 2018_day_01.input`"
    System.halt(1)
end
