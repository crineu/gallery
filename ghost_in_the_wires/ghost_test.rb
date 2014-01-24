require 'test/unit'

require File.dirname(__FILE__) + '/ghost.rb'

class GhostTest < Test::Unit::TestCase

	def test_rot_encode
		assert_equal "cdef", "abcd".rot_encode(2)
		assert_equal "zab", "xyz".rot_encode(2)
	end
	
	def test_rot_decode
		assert_equal "yzab", "abcd".rot(2)
		assert_equal "fkho", "fkho".rot(26)
	end

	def test_rot_encode_decode
		(0..26).each do |i|
			assert_equal "mksadhfa", "mksadhfa".rot_encode(i).rot(i)
		end
	end

	def test_vigenere_encode
		assert_equal "lxfo", "atta".vigenere_encode("lemo")
	end

	def test_vigenere_decode
		assert_equal "what was", "Wbth lal".vigenere("autopatc")
	end

	def test_vigenere_encode_decode
		['idj', 'osu', 'ksm', 'mmm', 'udh', 'zbz'].each do |key|
			assert_equal "phrase", "phrase".vigenere_encode(key).vigenere(key)
		end
	end

	def test_morse
		morse_code = ".... . .-.. .--.   -- .   --- ..- -   --- ..-.   - .... .. ...   .-- . .-.. .-.."
		assert_equal "HELP ME OUT OF THIS WELL", morse_code.decode_morse
	end

end