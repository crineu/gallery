require 'test/unit'
require File.dirname(__FILE__) + '/kata_5'

class TestKataFiveBloomFilter < Test::Unit::TestCase
    
    def test_hash_consistency
        words_list = %w(cavalo quadrado besta água Eusébio João caminhão)
        words_list.each do |word|
            hash_1 = Hashable.new(word).hash
            hash_2 = Hashable.new(word.upcase).hash # checks if case matters

            # puts hash_1.join(",\t")

            assert_equal hash_1, hash_2
            assert_equal HASH_FUNCTIONS, hash_1.size
            assert_equal HASH_FUNCTIONS, hash_2.size
        end
    end

    SAMPLE_WORDS = File.dirname(__FILE__) + "/words2_A"
    SAMPLE_WORDS_SIZE = SAMPLE_WORDS.size

    def test_universal_falsos_positivos
        filter = BloomFilter.new
        filter.load_all

        dic = Dictionary.new
        dic.load_all

        puts "Filtro e dicionário carregados @ #{Time.now.hour}:#{Time.now.min}"

        false_positives = 0
        IO.readlines(SAMPLE_WORDS).each do |line|
            word = line.strip
            if filter.has word and not dic.has word
                false_positives += 1
                puts "falso positivo: " + word
            end
        end

        puts " Report @ #{Time.now.hour}:#{Time.now.min}"
        puts " Hash functions = #{HASH_FUNCTIONS}"
        percentual = false_positives * 100.0 / SAMPLE_WORDS_SIZE
        puts " Falsos positivos: #{false_positives} => " + ("%3.2f%" % percentual)
    end
    
end

# Bits usados: 1.091.009 de 100.000.000
# Hash functions = 4
# Falsos positivos: 16215 => 54.31

# Bits usados: 1.084.665 de 100.000.000
# Hash functions = 4
# Falsos positivos: 16216 => 54.32

# Bits usados: 1.581.593 de 100.000.000
# Hash functions = 6
# Falsos positivos: 16265 => 54.48

# Bits usados: 1.632.132 de 100.000.000
# Hash functions = 6
# Falsos positivos: 16214 => 54.31

# Bits usados: 822.059 de 500.000.000
# Hash functions = 3
# Falsos positivos: 16222 => 54.34

# Bits usados: 819.331 de 100.000.000
# Hash functions = 3
# Falsos positivos: 16249 => 54.43

# Bits usados: 789.722 de 10.000.000
# Hash functions = 3
# Falsos positivos: 16609 => 55.63

