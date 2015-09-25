require 'kata6'
require 'test/unit'

class AnagramsEnglishTest < Test::Unit::TestCase

	def test_anagrams_english_wordlist
		anagrams = Anagrams.new "english_words"
		# anagrams.print_all
		# anagrams.print_sets 4
		puts "Total words: \t #{anagrams.num_of_words}"
		puts "Anagrams sets:\t #{anagrams.num_of_anagrams_sets}"
	end


end
# Total words: 	 275502
# Anagrams sets:	 24717
# .
# Finished in 14.161565 seconds.