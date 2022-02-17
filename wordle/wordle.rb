# 6026 palavras
WORDS_PT_BR = "br-sem-acentos-5-letras.txt"

DEBUG = true

class Wordle

  def initialize(lingua = WORDS_PT_BR)
    @dicionario = Hash.new { |hash, letra| hash[letra] = [] }

    File.readlines(lingua).each do |raw_word|
      palavra = raw_word.chomp.downcase
      @dicionario[palavra.chars.first] << palavra
    end

    puts "#{possibilidades} possibilidades" if DEBUG
  end

  def dict
    @dicionario
  end

  def chute
    @dicionario.values.shuffle.first.shuffle.first
  end

  def possibilidades
    @dicionario.values.reduce(0) { |soma, array| soma + array.size}
  end

  def tem(letras_que_tem)
    letras_que_tem.chars.each do |manter_letra|
      @dicionario.each_pair do |_k, array|
        array.delete_if { |palavra| not palavra.include?(manter_letra)}
      end
    end

    puts "#{possibilidades} possibilidades" if DEBUG
  end


  def nao_tem(letras_a_remover)
    letras_a_remover.chars.each do |letra_a_remover|
      @dicionario.delete(letra_a_remover)
      @dicionario.each_pair do |_k, array|
        array.delete_if { |palavra| palavra.include? letra_a_remover}
      end
    end

    puts "#{possibilidades} possibilidades" if DEBUG
  end

  def fixa_letra(letra_certa, posicao)
    if (0 == posicao)
      validos = @dicionario[posicao][letra_certa]
      @dicionario[posicao] = { letra_certa => validos }
    else
      @dicionario.each_pair do |_k, array|
        array.delete_if { |palavra| letra_certa != palavra.chars[posicao]}
      end
    end

    puts "#{possibilidades} possibilidades" if DEBUG
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
