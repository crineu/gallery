require 'kata6'
require 'test/unit'

class AnagramsTest < Test::Unit::TestCase

	def test_anagrams_mini_wordlist
		anagrams = Anagrams.new "mini_wordlist.txt"
		# anagrams.print_all
		# anagrams.print_sets
		puts "Total words: \t #{anagrams.num_of_words}"
		puts "Anagrams sets:\t #{anagrams.num_of_anagrams_sets}"
		
		assert_equal 22, anagrams.num_of_words
		assert_equal 8, anagrams.num_of_anagrams_sets
	end

end