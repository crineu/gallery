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
	RIDDLES[chapter.to_i] = riddle.chomp unless riddle.nil?
	ANSWERS[chapter.to_i] = answer.chomp unless answer.nil?
end


class SolutionsTest < Test::Unit::TestCase

	def test_riddle_1
		assert_equal RIDDLES[1], CODES[1].rot(2)
		assert_equal "autopatch", ANSWERS[1]
	end

	def test_riddle_2
		assert_equal RIDDLES[2], CODES[2].vigenere(ANSWERS[1])
		assert_equal "Sunset-Gower", ANSWERS[2]
	end

	def test_riddle_3
		assert_equal RIDDLES[3], CODES[3].rot(17)
		assert_equal "jelly", ANSWERS[3]
	end

	def test_riddle_4
		assert_equal RIDDLES[4], CODES[4].vigenere(ANSWERS[3])
		assert_equal "Steve Cooley", ANSWERS[4]
	end

	def test_riddle_5
		assert_equal RIDDLES[5], CODES[5].rot(5)
		assert_equal "Oroville", ANSWERS[5]
	end

	def test_riddle_6
		assert_equal RIDDLES[6], CODES[6].vigenere(ANSWERS[5])
		assert_equal "Hearts", ANSWERS[6]
	end

	def test_riddle_7
		assert_equal RIDDLES[7], CODES[7].rot(14)
		assert_equal "Bill Cook", ANSWERS[7]
	end

	def test_riddle_8
		assert_equal RIDDLES[8], CODES[8].vigenere(ANSWERS[7])
		assert_equal "150$", ANSWERS[8]
	end

	def test_riddle_9
		assert_equal RIDDLES[9], CODES[9].rot(11)
		assert_equal "firmware", ANSWERS[9]
	end

	def test_riddle_10
		assert_equal RIDDLES[10], CODES[10].vigenere(ANSWERS[9])
		assert_equal "Henry Spiegel", ANSWERS[10]
	end	

	def test_riddle_11
		assert_equal RIDDLES[11], CODES[11].rot(15)
		assert_equal "Calabasas", ANSWERS[11]
	end

	def test_riddle_12
		assert_equal RIDDLES[12], CODES[12].vigenere(ANSWERS[11])
		assert_equal "SAS", ANSWERS[12]
	end

	def test_riddle_13
		assert_equal RIDDLES[13], CODES[13].rot(3)
		assert_equal "Teltec", ANSWERS[13]
	end

	def test_riddle_14
		assert_equal RIDDLES[14], CODES[14].vigenere(ANSWERS[13])
		assert_equal "Village Market", ANSWERS[14]
	end

	def test_riddle_15
		assert_equal RIDDLES[15], CODES[15].rot(12)
		assert_equal "Optoelectronics", ANSWERS[15]
	end

	def test_riddle_16
		assert_equal RIDDLES[16], CODES[16].vigenere(ANSWERS[15])
		assert_equal "January 27", ANSWERS[16]
	end

	def test_riddle_17
		assert_equal RIDDLES[17], CODES[17].rot(8)
		assert_equal "Oakwood", ANSWERS[17]
	end

	def test_riddle_18
		assert_equal RIDDLES[18], CODES[18].vigenere(ANSWERS[17])
		assert_equal "WCC3", ANSWERS[18]
	end

	def test_riddle_19
		assert_equal RIDDLES[19], CODES[19].rot(21)
		assert_equal "Alphadent", ANSWERS[19]
	end

	def test_riddle_20
		assert_equal RIDDLES[20], CODES[20].vigenere(ANSWERS[19])
		assert_equal "Bob Burns", ANSWERS[20]
	end

	def test_riddle_21
		assert_equal RIDDLES[21], CODES[21].decode_hex.rot(13)
		assert_equal "Klingon", ANSWERS[21]
	end

	def test_riddle_22
		assert_equal RIDDLES[22], CODES[22].vigenere(ANSWERS[21])
		assert_equal "Kat", ANSWERS[22]
	end

	def test_riddle_23
		assert_equal RIDDLES[23], CODES[23].rot(9)
		assert_equal "boom box", ANSWERS[23]
	end

	def test_riddle_24
		assert_equal RIDDLES[24], CODES[24].vigenere(ANSWERS[23])
		assert_equal "Kinko", ANSWERS[24]
	end

	def test_riddle_25
		assert_equal RIDDLES[25], CODES[25].rot(6)
		assert_equal "Ellensburg", ANSWERS[25]
	end

	def test_riddle_26
		assert_equal RIDDLES[26], CODES[26].vigenere(ANSWERS[25])
		assert_equal "The Rockford Files", ANSWERS[26]
	end

	def test_riddel_27
		assert_equal RIDDLES[27], CODES[27].decode_decimal.rot(24)
		assert_equal "Tattered Cover", ANSWERS[27]
	end

	def test_riddle_28
		assert_equal RIDDLES[28], CODES[28].vigenere(ANSWERS[27])
		assert_equal "doc2", ANSWERS[28]
	end

	def test_riddle_29
		assert_equal RIDDLES[29], CODES[29].decode_octal.rot(25)
		assert_equal "snowbird", ANSWERS[29]
	end

	def test_riddle_30
		assert_equal RIDDLES[30], CODES[30].vigenere(ANSWERS[29])
		assert_equal "cylinder lock", ANSWERS[30]
	end

	def test_riddle_31
		assert_equal RIDDLES[31], CODES[31].rot(4)
		assert_equal "GTE Telenet", ANSWERS[31]
	end

	def test_riddle_32
		assert_equal RIDDLES[32], CODES[32].vigenere(ANSWERS[31])
		assert_equal "m00n$@earth", ANSWERS[32]
	end

	def test_riddle_33
		assert_equal RIDDLES[33], CODES[33].rot(18)
		assert_equal "Robert Morris", ANSWERS[33]
	end

	def test_riddle_34
		assert_equal RIDDLES[34], CODES[34].vigenere(ANSWERS[33])
		assert_equal "Direct link", ANSWERS[34]
	end

	def test_riddle_35
		assert_equal RIDDLES[35], CODES[35].decode_base36.rot(6)
		assert_equal "Players Club", ANSWERS[35]
	end

	def test_riddle_36
		assert_equal RIDDLES[36], CODES[36].vigenere(ANSWERS[35])
		assert_equal "Glasgow", ANSWERS[36]
	end

	def test_riddle_37
		assert_equal RIDDLES[37], CODES[37].decode_base64
		assert_equal "Kathleen Carson", ANSWERS[37]		
	end

	def test_riddle_38
		assert_equal RIDDLES[38], CODES[38].morse_normalize.morse
		assert_equal "FREE KEVIN", ANSWERS[38]
	end

	def test_print_them_all
		ANSWERS.each_index do |i|
			puts CODES[i]
			puts RIDDLES[i]
			puts ANSWERS[i]
			puts
		end
	end

end