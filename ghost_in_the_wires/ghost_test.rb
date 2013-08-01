require 'test/unit'

require File.dirname(__FILE__) + '/ghost.rb'

class GhostTest < Test::Unit::TestCase

	def test_rot
		assert_equal "cdef", "abcd".rot(2)
		assert_equal "zab", "xyz".rot(2)
	end
	
	def test_rot_negative
		assert_equal "yzab", "abcd".rot(-2)
		assert_equal "fkho", "fkho".rot(-26)
	end

	def test_rot_encode_decode
		(0..26).each do |i|
			assert_equal "mksadhfa", "mksadhfa".rot(i).rot_decode(i)
		end
	end

	def test_vigenere
		assert_equal "lxfo", "atta".vigenere("lemo")
	end

end