# 30130 palavras
WORDS_PT_BR = "br-sem-acentos-5-letras.txt"

class Wordle

  def initialize(lingua = WORDS_PT_BR)
    @dicionario = [
      Hash.new { |hash, letra| hash[letra] = [] },
      Hash.new { |hash, letra| hash[letra] = [] },
      Hash.new { |hash, letra| hash[letra] = [] },
      Hash.new { |hash, letra| hash[letra] = [] },
      Hash.new { |hash, letra| hash[letra] = [] }
    ]

    File.readlines(lingua).each do |raw_word|
      palavra = raw_word.chomp.downcase
      letras  = palavra.chars
      @dicionario[0][letras[0]] << palavra
      @dicionario[1][letras[1]] << palavra
      @dicionario[2][letras[2]] << palavra
      @dicionario[3][letras[3]] << palavra
      @dicionario[4][letras[4]] << palavra
    end
  end

  def dict
    @dicionario
  end

  def possibilidades
    @dicionario.map do |posicao|
      posicao.values.reduce(0) { |soma, array| soma + array.size}
    end.reduce(:+)
  end

  def remove_letra(letra_a_remover)
    @dicionario.each do |posicao|
      posicao.delete(letra_a_remover)
    end

  end

  def print_histogram(dicionario)
    puts "First letter"
    # h @dict[0].each_pair
  end

end


# dict = Wordle.new
# p dict.all_words.size
# p dict.words("k").size
# puts dict.words("x", 8)

# dict.print_letter_histogram("z")
# p dict.letter_histogram("z")
