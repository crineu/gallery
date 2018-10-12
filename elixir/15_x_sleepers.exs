# Create a process, send back message to parent
# Makes parent wait some time, than receive. What happens?

defmodule Replier do
  def reply do
    receive do
      {sender, message} ->
        IO.puts "Message sent!"
        send sender, "<< #{message}"

        # exit(:gone)
        raise "gave up"

    end
  end
end



# SPAWN_LINK
# pid = spawn_link(Replier, :reply, [])
# SPAWN_MONITOR
{pid, _} = spawn_monitor(Replier, :reply, [])



send pid, {self(), "lone msg"}
:timer.sleep 2000

receive do
  msg -> IO.puts "Message received: #{inspect msg}"
end
receive do
  msg -> IO.puts "Message received: #{inspect msg}"
after 1000 ->
  IO.puts "no second message"
end
