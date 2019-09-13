# Benchmark de diferentes métodos de implementação de fatorial
require 'benchmark'

# Common way of doing fatorial with while
def fatorial_while(num)
	result = 1
	while (num > 1)
		result *= num
		num = num -1
	end
	result
end

# Recursive fatorial implementation
def fatorial_recursivo(num)
	return num == 1 ? 1 : num * fatorial_recursivo(num-1)
end

# Fatorial with ruby inject method
def fatorial_inject(num)
	(2..num).inject { |x, num| x *= num }
end


numero = 9400

REPETICOES = 99
LARGURA_COLUNA = 16
Benchmark.bm(LARGURA_COLUNA) do |x|
  x.report("Using while")       { REPETICOES.times { fatorial_while(numero) } }
  x.report("Using recursion")   { REPETICOES.times { fatorial_recursivo(numero) } }
  x.report("Using inject")      { REPETICOES.times { fatorial_inject(numero)} }
end
