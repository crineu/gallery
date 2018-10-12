# Send 3 messages, receive them in a determined order
# (the :token parameter here does the magic ordering the responses)

defmodule Replier do
  def reply do
    receive do
      {sender, {token, message}} ->
        :timer.sleep :rand.uniform(500)
        send sender, {token, "<< #{message}"}
    end
  end
end

pid1 = spawn(Replier, :reply, [])
pid2 = spawn(Replier, :reply, [])
pid3 = spawn(Replier, :reply, [])

send pid1, {self(), {:token1, "1 msg 1"} }
send pid2, {self(), {:token2, "2 msg 2"} }
send pid3, {self(), {:token3, "3 msg 3"} }

receive do
  {:token2, value} ->
    IO.puts "--- received --- #{value}"
end
receive do
  {:token3, value} ->
    IO.puts "--- received --- #{value}"
end
receive do
  {:token1, value} ->
    IO.puts "--- received --- #{value}"
end