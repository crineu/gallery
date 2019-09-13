require 'benchmark'
# Muellers recursion

module MuellerRecursion
  module Float
    def self.f(y, z)
      108 - ((815 - 1500/z) / y)
    end

    def self.x(i)
      r = [4.0, 4.25]
      (2..i).each { |index| r << f(r[index-1], r[index-2]) }
      r[i]
    end

    def self.x_recursive(i)
      return 4.0  if i == 0
      return 4.25 if i == 1

      f(x(i-1), x(i-2))
    end
  end

  module Rational
    def self.f(y, z)
      108 - Rational(815 - Rational(1500, z), y)
    end

    def self.x(i)
      r = [4.0, 4.25]
      (2..i).each { |index| r << f(r[index-1], r[index-2]) }
      r[i]
    end
  end
end


def muellers_float(i)
  (0..i).map { |n| MuellerRecursion::Float.x(n) }
end

def muellers_memory(i)
  mem = MuellerRecursion::Memory.new
  (0..i).map { |n| mem.x(n) }
end

def muellers_rational(i)
  (0..i).map { |n| MuellerRecursion::Rational.x(n).to_f }
  # (0..i).map { |n| MuellerRecursion::Rational.x(n).rationalize(0.00000001) }
end

numero = 100

# muellers_float(numero).each_with_index { |r, i| puts "#{i} \t #{r}"}
muellers_rational(numero).each_with_index { |r, i| puts "#{i} \t #{r}"}

# LARGURA_COLUNA = 16
# Benchmark.bm(LARGURA_COLUNA) do |x|
#   x.report("Using float")     { MuellerRecursion::Float.x(numero)         }
#   x.report("Using rational")  { MuellerRecursion::Rational.x(numero).to_f }
# end
