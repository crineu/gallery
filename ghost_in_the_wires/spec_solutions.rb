require 'minitest/autorun'
require File.dirname(__FILE__) + '/ghost.rb'


def file_to_array(file_name)\
	array = []
	File.readlines(file_name).each do |line|
		chapter, text = line.split("\t")
		array[chapter.to_i] = text.chomp unless text.nil?
	end
	array
end

describe "Tests for all chapters solutions" do

	before do 
		CODES   ||= file_to_array('chapter_codes')
		RIDDLES ||= file_to_array('chapter_riddles')
		ANSWERS ||= file_to_array('chapter_answers')		
	end
	
	describe "most of the odd chapters use ROT" do
		it "chapter 1 is decyphered with index 2" do
			CODES[1].rot(2).must_equal RIDDLES[1]
		end
		it "chapter 3 is decyphered with index 17" do
			CODES[3].rot(17).must_equal RIDDLES[3]
		end
		it "chapter 5 is decyphered with index 5" do
			CODES[5].rot(5).must_equal RIDDLES[5]
		end
		it "chapter 7 is decyphered with index 14" do
			CODES[7].rot(14).must_equal RIDDLES[7]
		end
		it "chapter 9 is decyphered with index 11" do
			CODES[9].rot(11).must_equal RIDDLES[9]
		end
		it "chapter 11 is decyphered with index 15" do
			CODES[11].rot(15).must_equal RIDDLES[11]
		end
		it "chapter 13 is decyphered with index 3" do
			CODES[13].rot(3).must_equal RIDDLES[13]
		end
		it "chapter 15 is decyphered with index 12" do
			CODES[15].rot(12).must_equal RIDDLES[15]
		end
		it "chapter 17 is decyphered with index 8" do
			CODES[17].rot(8).must_equal RIDDLES[17]
		end
		it "chapter 19 is decyphered with index 21" do
			CODES[19].rot(21).must_equal RIDDLES[19]
		end
		it "chapter 23 is decyphered with index 9" do
			CODES[23].rot(9).must_equal RIDDLES[23]
		end
		it "chapter 25 is decyphered with index 6" do
			CODES[25].rot(6).must_equal RIDDLES[25]
		end
		it "chapter 31 is decyphered with index 4" do
			CODES[31].rot(4).must_equal RIDDLES[31]
		end
		it "chapter 33 is decyphered with index 18" do
			CODES[33].rot(18).must_equal RIDDLES[33]
		end
	end

	describe "all even chapters use vigenere" do
		2.step(37, 2).each do |chapter|
			it "uses previous chapters answers as key" do
				previos_chapter_answer = ANSWERS[chapter - 1]
				CODES[chapter].vigenere(previos_chapter_answer).must_equal RIDDLES[chapter]
			end
		end
	end

	describe "some chapters are special" do
		it "chapter 21 is in hexadecimal, and uses ROT with index 13" do
			CODES[21].decode_hex.rot(13).must_equal RIDDLES[21]
		end

		it "chapter 27 is encoded in decimal, and uses ROT with index 24" do 
			CODES[27].decode_decimal.rot(24).must_equal RIDDLES[27]
		end

		it "chapter 29 is encoded in octal, and uses ROT with index 25" do
			CODES[29].decode_octal.rot(25).must_equal RIDDLES[29]
		end

		it "chapter 35 is in base 36, and uses ROT with index 6" do
			CODES[35].decode_base36.rot(6).must_equal RIDDLES[35]
		end

		it "chapter 37 is in base64" do 
			assert_equal RIDDLES[37], CODES[37].decode_base64
		end

		it "last chapter (38) uses morse code" do
			CODES[38].morse_normalize.morse.must_equal RIDDLES[38]
		end
	end

end

