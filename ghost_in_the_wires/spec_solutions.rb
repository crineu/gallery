require 'minitest/autorun'
require_relative 'ghost.rb'

def file_to_array(file_name)
    array = []
    File.readlines(file_name).each do |line|
        chapter, text = line.split("\t")
        array[chapter.to_i] = text.chomp unless text.nil?
    end
    array
end

describe "Test all chapters solutions" do

    before do
        CODES   ||= file_to_array('chapter_codes')
        RIDDLES ||= file_to_array('chapter_riddles')
        ANSWERS ||= file_to_array('chapter_answers')
    end

    describe "most of the odd chapters use ROT" do
        {1=>2, 3=>17, 5=>5, 7=>14, 9=>11, 11=>15, 13=>3, 15=>12,
         17=>8, 19=>21, 23=>9, 25=>6, 31=>4, 33=>18}.each_pair do |chapter, key|
            it "chapter #{chapter} is decyphered using key #{key}" do
                CODES[chapter].rot(key).must_equal RIDDLES[chapter]
            end
        end
    end

    describe "even chapters use vigenere cypher" do
        2.step(37, 2).each do |chapter|
            it "chapter #{chapter} uses previous chapter (#{chapter-1}) answers as key" do
                previous_chapter_answer = ANSWERS[chapter - 1]
                CODES[chapter].vigenere(previous_chapter_answer).must_equal RIDDLES[chapter]
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
            CODES[37].decode_base64.must_equal RIDDLES[37]
        end

        it "chapter 38 uses morse code" do
            CODES[38].morse_normalize.morse.must_equal RIDDLES[38]
        end
    end

end

