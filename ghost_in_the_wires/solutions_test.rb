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
NEW_LINE = "\n" # deprecated... remove

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

	def ttest_solve_them_all
		puts CODES[6].vigenere("oroville") + "==> hearts" + NEW_LINE
		puts CODES[7].rot(14) + "==> Bill Cook" + NEW_LINE
		puts CODES[8].vigenere("billcook") + "==> $150" + NEW_LINE
		puts CODES[9].rot(11) + "==> firmware" + NEW_LINE
		puts CODES[10].vigenere("firmware") + "==> Henry Spiegel" + NEW_LINE
		puts CODES[11].rot(15) + "==> calabasas" + NEW_LINE
		puts CODES[12].vigenere("calabasas") + "==> SAS" + NEW_LINE
		puts CODES[13].rot(3) + "==> teltec" + NEW_LINE
		puts CODES[14].vigenere("teltec") + "==> Village Market" + NEW_LINE
		puts CODES[15].rot(12) + "==> optoelectronics" + NEW_LINE
		puts CODES[16].vigenere("optoelectronics") + "==> January 27" + NEW_LINE
		puts CODES[17].rot(8) + "==> oakwood" + NEW_LINE
		puts CODES[18].vigenere("oakwood") + "==> WCC3" + NEW_LINE
		puts CODES[19].rot(21) + "==> alphadent" + NEW_LINE
		puts CODES[20].vigenere("alphadent") + "==> bob burns" + NEW_LINE
		puts CODES[21].decode_hex.rot(13) + "\n==> klingon" + NEW_LINE
		puts CODES[22].vigenere("klingon") + "==> kat" + NEW_LINE
		puts CODES[23].rot(9) + "==> boom box" + NEW_LINE
		puts CODES[24].vigenere("boombox") + "==> kinko" + NEW_LINE
		puts CODES[25].rot(6) + "==> ellensburg" + NEW_LINE
		puts CODES[26].vigenere("ensburgell") + "==> The Rockford Files" + NEW_LINE
		puts CODES[27].rot(0) + "==> " + NEW_LINE

		# CODES[27].print_all_rot
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