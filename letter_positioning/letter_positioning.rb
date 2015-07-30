# Based in the foreword of Thinking Fast and Slow:
# There are more words that starts with k or have k as 3rd letter?

class Dictionary
    def initialize
        @words = Hash.new { |hash, key| hash[key] = [] }
        File.readlines("english_words.txt").each do |raw_word|
            word = raw_word.chomp.downcase
            word.each_char { |chr| @words[chr] << word }
        end
        @words.values.each { |value| value.uniq!  }
    end

    def all_words
        @words
    end

    def words(letter, position = 0)
        result = []
        @words[letter].each do |word|
            next if word[position].nil?
            result << word if word[position] == letter
        end
        result
    end

    def letter_histogram(letter)
        hist = []
        1..10.times do |position|
            hist << words(letter, position).size
        end
        hist
    end

    def print_letter_histogram(letter)
        string_position = "* position  "
        string_quantity = "- letter #{letter}  "
        1..10.times do |position|
            occurrences = words(letter, position).size

            string_position << " | #{(position + 1).to_s.center(4)}"
            string_quantity << " | #{occurrences.to_s.rjust(4)}"
        end
        puts string_position
        puts string_quantity
    end

    def print_all_letters_histogram
        string_position = "* position  "
        1..10.times do |position|
            string_position << " | #{(position + 1).to_s.center(5)}"
        end
        puts string_position

        ('a'..'z').each do |letter|
            string_quantity = "- letter #{letter}  "
            1..10.times do |position|
                occurrences = words(letter, position).size
                string_quantity << " | #{occurrences.to_s.rjust(5)}"
            end
            puts string_quantity
        end
    end
end


dict = Dictionary.new
# p dict.all_words.size
# p dict.words("k").size
# puts dict.words("x", 8)

# dict.print_letter_histogram("z")
# p dict.letter_histogram("z")
dict.print_all_letters_histogram