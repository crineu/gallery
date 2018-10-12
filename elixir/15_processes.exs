defmodule SpawnBasic do
  def greet do
    IO.puts "from process"
  end

end

IO.puts "  # Usual way:"
IO.inspect SpawnBasic.greet

IO.puts "  # Spawn way:"
IO.inspect spawn(SpawnBasic, :greet, [])
IO.puts ""

# ---

defmodule Spawn1 do
  def greet do
    receive do
      {sender, message} ->
        send sender, { :ok, "Oi, #{message}"}
        greet()
    end
  end
end

pid = spawn(Spawn1, :greet, [])

send pid, {self(), "euzinho"}
receive do
  {:ok, message} ->
    IO.puts message
end

send pid, {self(), "segundo eu"}
receive do
  {:ok, message} ->
    IO.puts message
  after 500 ->
    IO.puts "Time out!"
end

send pid, {self(), "terceiro"}
receive do
  {:ok, message} ->
    IO.puts message
  after 500 ->
    IO.puts "Time out!"
end


IO.puts ""
IO.puts "when processes die - spawn_link"
defmodule Link2 do
  def sleepy_function do
    :timer.sleep 500
    exit(:boom2)
  end

  def run do
    Process.flag(:trap_exit, true)
    spawn_link(Link2, :sleepy_function, [])
    receive do
      msg -> IO.puts "Message received: #{inspect msg}"
    after 1000 ->
      IO.puts "Nothing happened as far as I am concerned"
    end
  end
end

Link2.run


IO.puts ""
IO.puts "when processes die - spawn_monitor"
defmodule Monitor1 do
  def sleepy_function do
    :timer.sleep 500
    exit(:boom3)
  end

  def run do
    res = spawn_monitor(Monitor1, :sleepy_function, [])
    IO.inspect res
    receive do
      msg -> IO.puts "Message received: #{inspect msg}"
    after 1000 ->
      IO.puts "Nothing happened as far as I am concerned"
    end
  end
end

Monitor1.run


#
IO.puts ""
IO.puts "Parallel Map!"

defmodule Parallel do
  def pmap(coolection, fun) do
    me = self()
    coolection
      |> Enum.map(fn (elem) ->
           spawn_link fn -> (send me, { self(), fun.(elem) } ) end
         end)
      |> Enum.map(fn (pid) ->
           receive do {^pid, result} -> result end
         end)
  end
end

IO.inspect Parallel.pmap 1..15, &(&1 * &1)
