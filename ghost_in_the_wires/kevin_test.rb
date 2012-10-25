require 'test/unit'

# require File.dirname(__FILE__) + '/../test_helper'
require File.dirname(__FILE__) + '/kevin.rb'

class CaesarTest < Test::Unit::TestCase

	def test_a_for_b
		kevin = Kevin.new("abcdef")
		kevin.keys = "a b"
		assert_equal "bbcdef", kevin.decypher
	end

	def test_words
		kevin = Kevin.new("uiop zxc")
		kevin.keys = "uiop fuck, zxc you"
		assert_equal "fuck you", kevin.decypher
	end

	def test_case
		kevin = Kevin.new("aA Bb Cc")
		kevin2 = Kevin.new("aA Bb Cc")
		
		kevin.keys = {"a" => "x", "b" => "y", "c" => "z"}
		kevin2.keys = "a x, b y, c z"
		
		assert_equal "xX Yy Zz", kevin.decypher
		assert_equal "xX Yy Zz", kevin2.decypher
	end


end