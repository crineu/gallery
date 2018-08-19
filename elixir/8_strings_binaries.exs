IO.puts "----"
IO.write "
    multi-line
    string wrongly defined
"
IO.puts "xxxx"

# Heredocs
IO.puts "----"
IO.write  """
    now multi-line
    with heredocs
    """
IO.puts "xxxx"


# Sigils
IO.puts "\n"
IO.puts ~C[1\n2#{1+2} char list with no scape or interpolation]
IO.puts ~c[1\n2#{1+2} char list scaped and interpolated]
IO.puts ~S[1\n2#{1+2} string with no scape or interpolation]
IO.puts ~s/1\n2#{1+2} string scaped and interpolated/

IO.inspect ~W[the c#{'a'}t on space-delted words, no-scape-or-interp]
IO.inspect ~w[the c#{'a'}t on space-delted words, scaped-and-interp]

IO.inspect ~w[list of atoms]a
IO.inspect ~w[list of char list]c
IO.inspect ~w[list of sring list]s


# Ex1: Functions return true if list contains only ASCII chars (space to tilde)
defmodule Char do
  @first ?\s
  @last  ?~
  def only_ascii?([char1 | []])
  when char1 >= @first and char1 <= @last do
    true
  end
  def only_ascii?([char1 | tail])
  when char1 >= @first and char1 <= @last do
    only_ascii?(tail)
  end
  def only_ascii?([_not_printable | _]), do: false
end

IO.puts "'abcde' only_ascii? #{Char.only_ascii? 'abcde'}"
IO.puts "'*^&#~' only_ascii? #{Char.only_ascii? '*^&#~'}"
IO.puts "'*^ #~' only_ascii? #{Char.only_ascii? '*^ #~'}"



# Ex2: write anagram?(word1, word2) function: true if is anagram
defmodule Word do
  def anagram?(word1, word2), do: Enum.sort(word1) == Enum.sort(word2)
end

IO.puts "anagram? 'abc', 'abc' #{Word.anagram? 'abc', 'abc'}"
IO.puts "anagram? 'acb', 'bac' #{Word.anagram? 'acb', 'bac'}"
IO.puts "anagram? 'acb', 'baac' #{Word.anagram? 'acb', 'baac'}"
IO.puts "anagram? 'sample', 'maples' #{Word.anagram? 'sample', 'maples'}"



# Binaries
IO.puts "\n - - - BINARIES - - -"

bin = << 3, 4, 8 >>
IO.write "<< 3, 4, 8 >>"
IO.write "\t|| byte_size #{byte_size bin}"
IO.puts  "\t|| bit size #{bit_size bin}"

bin = << 3::size(3), 8::size(4) >>
IO.write "<< 3::size(3), 8::size(4) >>"
IO.write "\t\t|| byte_size #{byte_size bin}"
IO.puts  "\t||bit size #{bit_size bin}"


# Strings are binaries
utf8 = "£λ"
euro_code = "\u00a3"

IO.puts ""
IO.write "string '#{utf8}'"
IO.write " | lenght = #{String.length utf8}"
IO.write " | byte size = #{byte_size utf8}"
IO.puts " | bit size = #{bit_size utf8}"

IO.puts "euro equals utf8_code u00a3 = #{euro_code == String.at(utf8, 0)}"

noel = "noe\u0308l"
IO.puts noel
IO.puts "codepoints => #{inspect String.codepoints(noel)}"
IO.puts "graphemes  => #{inspect String.graphemes(noel)}"

IO.puts "\njaro distance josé e Jose: #{String.jaro_distance("josé", "Jose")}"
IO.puts "myers diference from 'cachaça' to 'palhaça"
IO.inspect String.myers_difference "cachaça", "palhaça"

IO.puts ""
IO.puts String.pad_leading("alinhamento", 20, "-_")


# Ex 5
defmodule StringAligner do
  def center(word_list) when is_list(word_list) do
    longest = word_list
      |> Enum.max_by(&String.length/1)
      |> String.length
    _print_word(word_list, longest)
  end

  defp _print_word([], _), do: nil
  defp _print_word([head | tail], longest) do
    offset = String.length(head) + longest |>  div(2)
    IO.puts String.pad_leading(head, offset)
    _print_word(tail, longest)
  end

end

IO.puts "\n==> EX 5"
StringAligner.center(Enum.shuffle ~w[cat £ zebra elephant Gorbachev λ])


# Ex 6
defmodule Capitalize do
  @marker ". "
  def sentence(binary) when is_binary(binary) do
    String.split(binary, @marker)
     |> Enum.map(&String.capitalize/1)
     |> Enum.join(@marker)
  end
end

IO.puts ""
IO.puts "oh. a DOG. wOoF."
IO.puts Capitalize.sentence "oh. a DOG. wOoF."


# List compreensions sample
# prices = [ bananas: 1.80, milk: 4.00 ] # keyword list
# cart = [
#   [id: 1, name: :bananas],
#   [id: 2, name: :milk],
#   [id: 3, name: :bananas],
#   [id: 4, name: :yoghurt]
# ] # list of keyword lists
# IO.inspect for item <- cart,
#   {_, item_name} <- item, # generator
#   (item_name in Keyword.keys prices), # filter
#   {name, price} <- prices, # generator
#   item_name == name, # filter
#   do: price


# Ex 7
IO.puts "\n~~~ Complementação exercício cap anterior"
IO.inspect tax_rates = [ NC: 0.075, TX: 0.08 ]

# function to return orders with tax_rate:
defmodule Tax do
  def fix_table(orders, rates) do
    for order <- orders, do: order ++ _total_amount(order[:net_amount], rates[order[:ship_to]])
  end

  defp _total_amount(net_amount, nil), do: [ total_amout: net_amount             ]
  defp _total_amount(net_amount, tax), do: [ total_amout: (net_amount * (1+tax)) ]
end

orders = [
  # [ id: 123, ship_to: :NC, net_amount: 100.00 ],
  # ...
  # [ id: 130, ship_to: :NC, net_amount:  50.00 ],
]

defmodule CSV do
  def to_key_list(file_name) do
    {:ok, file} = File.open(file_name, [:read])
    [head | data] = IO.read(file, :all) |> String.split("\n")
    File.close(file)

    list_keys = head |> String.split(",") |> Enum.map(&String.to_atom/1)
    data
      |> Enum.map(&String.split(&1, ","))
      |> Enum.map(&_parse_line(&1))
      |> Enum.map(&Enum.zip(list_keys, &1))
  end

  defp _parse_line([id, city, amnt]) do
    [
      id   |> String.to_integer,
      city |> String.trim(":") |> String.to_atom,
      amnt |> Float.parse |> elem(0)
    ]
  end
end

IO.inspect orders = CSV.to_key_list "8.1_sales.csv"
IO.inspect Tax.fix_table(orders, tax_rates)
