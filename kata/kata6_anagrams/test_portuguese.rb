require 'kata6'
require 'test/unit'

class AnagramsPortugueseTest < Test::Unit::TestCase

	def test_anagrams_portuguese_wordlist
		anagrams = Anagrams.new "portuguese_words"
		# anagrams.print_all
		# anagrams.print_sets 5
		puts "Total words: \t #{anagrams.num_of_words}"
		puts "Anagrams sets:\t #{anagrams.num_of_anagrams_sets}"
	end


end