defmodule Progress do
  @precision 2
  @bar_size  50
  @complete_character "█"
  @incomplete_character "░"

  def bar(count, total) do
    percent = percent_complete(count, total)
    divisor = 100 / @bar_size

    complete_count = round(percent / divisor)
    incomplete_count = @bar_size - complete_count

    complete   = String.duplicate(@complete_character,   complete_count)
    incomplete = String.duplicate(@incomplete_character, incomplete_count)

    "#{complete}#{incomplete}  (#{percent}%)"
  end

  defp percent_complete(count, total) do
    Float.round(100.0 * count / total, @precision)
  end

end


total = 47

Enum.each(1..total, fn task ->
  IO.write("\r#{Progress.bar(task, total)}")
  Process.sleep(10 + :rand.uniform(260))
end)

IO.write("\n")
