require 'test/unit'
require File.dirname(__FILE__) + '/string_calculator'

class TestStringCalculator < Test::Unit::TestCase

	def test_empty
		assert_equal 0, "".add
	end

	def test_one_digit
		assert_equal 0, "0".add
		assert_equal 1, "1".add
		assert_equal 5, "5".add
	end

	def test_two_digits
		assert_equal 3, "1,2".add
		assert_equal 5, "3,2".add
		assert_equal 20, "5,15".add
		assert_equal 926, "304,622".add
	end

	def test_many_digits
		assert_equal 6, "1,2,3".add
		assert_equal 10, "1,2,3,4".add
		assert_equal 15, "1,2,3,4,5".add
		assert_equal 2173, "100,200,1873".add
	end

	def test_allow_new_line
		assert_equal 6, "1\n2,3".add
		assert_equal 16, "1\n2,3\n10".add
	end
	
	def test_allow_different_delimiter
		assert_equal 3, "//;\n1;2".add
		assert_equal 19, "//;\n1;2;6;10".add
		assert_equal 20, "//-\n5-8-7".add
	end

	def test_throw_exception_when_negatives_called
		error = assert_raise(RuntimeError) { "8,-2".add }
		assert_equal 'Negatives not allowed: -2', error.message
	    
	    error = assert_raise(RuntimeError) { "8,-2,4,-9".add }
		assert_equal 'Negatives not allowed: -2, -9', error.message
	end
end
