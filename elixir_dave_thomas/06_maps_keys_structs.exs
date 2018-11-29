# Keywords lists used when passing parameters
defmodule Canvas do
  @defaults [ fg: "BLACK", bg: "WHITE" ]

  def draw_text(text, options \\ []) do
    options = Keyword.merge(@defaults, options)
    IO.puts "text:  #{inspect(text)}"
    IO.puts "fg:    #{options[:fg]}"
    IO.puts "bg:    #{Keyword.get(options, :bg)}"
    IO.puts "resto: #{inspect Keyword.get_values(options, :param)}"
  end
end

Canvas.draw_text("bozo")
Canvas.draw_text("bozo", fg: "red", bg: "whathever")
Canvas.draw_text("bozo", fg: "red", bg: "whathever", param: "novo param", param: "outro")


# Maps and Pattern Matching
IO.puts "\nMAPS AND PATTERN MATCHING"
person = %{ name: "Dave", height: 1.88 }

%{ name: a_name } = person
IO.puts a_name
%{ name: _, height: _} = person
 # %{ address: _, height: _} = person   => (MatchError)

people = [
  %{ name: "Grumpy",  height: 1.24 },
  %{ name: "Dave",    height: 1.88 },
  %{ name: "Dopey",   height: 1.32 },
  %{ name: "Shaq",    height: 2.16 },
  %{ name: "Sneezy",  height: 1.28 }
]

IO.inspect(for person = %{ height: h } <- people, h > 1.5, do: person)

defmodule Hotel do
  def book(%{name: name, height: height}) when height > 1.9 do
    IO.puts "Need etra long bed for #{name}"
  end
  def book(%{name: name, height: height}) when height < 1.3 do
    IO.puts "Need low shower controls for #{name}"
  end
  def book(%{name: name }) do
    IO.puts "Normal bed for #{name}"
  end
end

people |> Enum.each(&Hotel.book/1)

# Map update
IO.inspect m = %{ a: 1, b: 2, c: 3 }
IO.inspect m1 = %{ m | b: "two"}
IO.inspect %{ m1 | a: "one", c: "three" }


# Structs
IO.puts "\nSTRUCTS"
defmodule Attendee do
  defstruct name: "", paid: false, over_18: true

  def may_attend_after_party(attendee = %Attendee{}) do
    attendee.paid && attendee.over_18
  end

  def has_name(%Attendee{ name: name}) when name != "" do
    IO.puts "Tem nome e é #{name}"
  end
  def has_name(%Attendee{}) do
    raise "Não tem nome o cidadão"
  end
end

# Nested Struct...
# Access Module....


# Sets
IO.puts "SETS!"
IO.inspect set1 = 1..5 |> Enum.into(MapSet.new)
IO.inspect set2 = 3..8 |> Enum.into(MapSet.new)
IO.puts MapSet.member? set1, 3
IO.inspect MapSet.union      set1, set2
IO.inspect MapSet.difference set1, set2
IO.inspect MapSet.difference set2, set1
IO.inspect MapSet.intersection set2, set1
