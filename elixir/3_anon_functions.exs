double = fn(n) -> n * 2 end
IO.puts double.(83)

greet = fn -> IO.puts "Hello" end
greet.()

swap = fn{a, b} -> {b, a} end
IO.puts inspect swap.({:first, :last})

list_concat = fn a, b -> a ++ b end
IO.puts inspect list_concat.([:a, :b], [:c, :d])

sum = fn(a, b, c) -> a + b + c end
IO.puts sum.(1, 2, 3)

pair_tuple_to_list = fn {a, b} -> [a, b] end
IO.puts inspect pair_tuple_to_list.({1234, 5678})

# ---

handle_opener = fn
  {:ok, file} -> "Read data: #{IO.read(file, :line)}"
  {_,  error} -> "Error: #{:file.format_error(error)}"
end

IO.puts handle_opener.(File.open("passwd.sample"))
IO.puts handle_opener.(File.open("non.ecxiste"))


func3 = fn
  0, 0, c -> "FizzBuzz"
  0, b, c -> "Fizz"
  a, 0, c -> "Buzz"
  a, b, c -> c
end
fizzBuzz = fn(n) -> func3.(rem(n,3), rem(n,5), n) end

IO.puts fizzBuzz.(10)
IO.puts fizzBuzz.(11)
IO.puts fizzBuzz.(12)
IO.puts fizzBuzz.(13)
IO.puts fizzBuzz.(14)
IO.puts fizzBuzz.(15)
IO.puts fizzBuzz.(16)


# Function returns function
prefix = fn
  first_name -> fn
    last_name -> "#{first_name} #{last_name}"
  end
end

elixir = prefix.("Elixir")
IO.puts elixir.("Rocks")
IO.puts prefix.("Elixir").("Rocks")


# Function as parameter of another function
list = [1, 3, 5, 7, 11]
IO.puts inspect Enum.map list, fn elem -> elem * 3 end
IO.puts inspect Enum.map list, &(&1 * &1)
IO.puts inspect Enum.map list, &(&1 > 6)


# PINNED VALUES AND FUNCTION PARAMETERS
defmodule Saudador do
  def for(nome, saudacao) do
    fn
      (^nome) -> "#{saudacao}, master #{nome}"
      (_)     -> "No no no no... you have not this name"
    end
  end
end

master_luke = Saudador.for("Luke", "Helllllloooo")
IO.puts master_luke.("Luke")
IO.puts master_luke.("Han")


divrem = &{ div(&1, &2), rem(&1, &2) }
IO.puts inspect divrem.(38, 11)

# anonymous function of a named one
comprimento = &length/1
IO.puts comprimento.([2, 48, 2, 3])
