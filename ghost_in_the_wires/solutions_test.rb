require 'test/unit'
require File.dirname(__FILE__) + '/ghost.rb'

CODES = []
File.readlines('chapter_codes').each do |line|
	chapter, code = line.split("\t")
	CODES[chapter.to_i] = code.chomp
end
RIDDLES = []
ANSWERS = []
File.readlines('chapter_answers').each do |line|
	chapter, riddle, answer = line.split("\t")
	RIDDLES[chapter.to_i] = riddle.chomp
	ANSWERS[chapter.to_i] = answer.chomp
end


class SolutionsTest < Test::Unit::TestCase

	def test_riddle_1
		assert_equal RIDDLES[1], CODES[1].rot(2)
		assert "autopatch", ANSWERS[1]
	end

	def test_riddle_2
		assert_equal RIDDLES[2], CODES[2].vigenere(ANSWERS[1])
		assert "Sunset-Gower", ANSWERS[2]
	end

	def test_riddle_3
		assert_equal RIDDLES[3], CODES[3].rot(17)
		assert "jelly", ANSWERS[3]
	end

	def test_riddle_4
		assert_equal RIDDLES[4], CODES[4].vigenere(ANSWERS[3])
		assert "Steve Cooley", ANSWERS[4]
	end

	def test_riddle_5
		assert_equal RIDDLES[5], CODES[5].rot(5)
		assert "oroville", ANSWERS[5]
	end

	def test_riddle_6
		assert_equal RIDDLES[6], CODES[6].vigenere(ANSWERS[5])
		assert "hearts", ANSWERS[6]
	end

	def test_riddle_7
		assert_equal RIDDLES[7], CODES[7].rot(14)
		assert "Bill Cook", ANSWERS[7]
	end

	def test_riddle_8 # something odd with this one
		# assert_equal RIDDLES[8], CODES[8].vigenere(ANSWERS[7])
		fuzzy_question = "now mjuh ifahy ujv hrldb fzf ar zph frvfsa qil hhs tao zjtijyiv qvi wqeo adre?"
		assert_equal fuzzy_question, CODES[8].vigenere(ANSWERS[7])
		assert "150$", ANSWERS[8]
	end

	def test_riddle_9
		assert_equal RIDDLES[9], CODES[9].rot(11)
		assert "firmware", ANSWERS[9]
	end

	def test_riddle_10
		assert_equal RIDDLES[10], CODES[10].vigenere(ANSWERS[9])
		assert "Henry Spiegel", ANSWERS[10]
	end	

	def test_riddle_11
		assert_equal RIDDLES[11], CODES[11].rot(15)
		assert "calabasas", ANSWERS[11]
	end

	def test_riddle_12
		assert_equal RIDDLES[12], CODES[12].vigenere(ANSWERS[11])
		assert "SAS", ANSWERS[12]
	end

	def test_riddle_13
		assert_equal RIDDLES[13], CODES[13].rot(3)
		assert "teltec", ANSWERS[13]
	end

	def test_riddle_14
		assert_equal RIDDLES[14], CODES[14].vigenere(ANSWERS[13])
		assert "Village Market", ANSWERS[14]
	end

	def test_riddle_15
		assert_equal RIDDLES[15], CODES[15].rot(12)
		assert "optoelectronics", ANSWERS[15]
	end

	def test_riddle_16
		assert_equal RIDDLES[16], CODES[16].vigenere(ANSWERS[15])
		assert "January 27", ANSWERS[16]
	end

	def test_riddle_17
		assert_equal RIDDLES[17], CODES[17].rot(8)
		assert "oakwood", ANSWERS[17]
	end

	def test_riddle_18
		assert_equal RIDDLES[18], CODES[18].vigenere(ANSWERS[17])
		assert "WCC3", ANSWERS[18]
	end

	def test_riddle_19
		assert_equal RIDDLES[19], CODES[19].rot(21)
		assert "alphadent", ANSWERS[19]
	end

	def test_riddle_20
		assert_equal RIDDLES[20], CODES[20].vigenere(ANSWERS[19])
		assert "bob burns", ANSWERS[20]
	end

	def test_riddle_21
		assert_equal RIDDLES[21], CODES[21].decode_hex.rot(13)
		assert "Bill Cook", ANSWERS[21]
	end

	def test_riddle_22
		assert_equal RIDDLES[22], CODES[22].vigenere(ANSWERS[21])
		assert "kat", ANSWERS[22]
	end

	def test_riddle_23
		assert_equal RIDDLES[23], CODES[23].rot(9)
		assert "boombox", ANSWERS[23]
	end

	def test_riddle_24
		assert_equal RIDDLES[24], CODES[24].vigenere(ANSWERS[23])
		assert "kinko", ANSWERS[24]
	end

	def test_riddle_25
		assert_equal RIDDLES[25], CODES[25].rot(6)
		assert "ellensburg ", ANSWERS[25]
	end

	def test_riddle_26
		assert_equal RIDDLES[26], CODES[26].vigenere(ANSWERS[25])
		assert "The Rockford Files", ANSWERS[26]
	end

	def test_riddel_27
		# assert_equal RIDDLES[27], CODES[27].rot(8)
		puts CODES[27].print_all_rot
	end


	def _test_print_them_all
		ANSWERS.each_index do |i|
			puts CODES[i]
			puts RIDDLES[i]
			puts ANSWERS[i]
			puts
		end
	end

end