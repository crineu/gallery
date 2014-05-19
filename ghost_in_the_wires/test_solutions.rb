require 'minitest/autorun'
require File.dirname(__FILE__) + '/ghost.rb'

def file_to_array(file_name)
    array = []
    File.readlines(file_name).each do |line|
        chapter, text = line.split("\t")
        array[chapter.to_i] = text.chomp unless text.nil?
    end
    array
end

class SolutionsTest < Minitest::Test

    def setup
        @@codes   ||= file_to_array('chapter_codes')
        @@riddles ||= file_to_array('chapter_riddles')
        @@answers ||= file_to_array('chapter_answers')
    end

    def test_riddle_chapter_1
        assert_equal @@riddles[1], @@codes[1].rot(2)
        assert_equal "autopatch", @@answers[1]
    end

    def test_riddle_chapter_2
        assert_equal @@riddles[2], @@codes[2].vigenere(@@answers[1])
        assert_equal "Sunset-Gower", @@answers[2]
    end

    def test_riddle_chapter_3
        assert_equal @@riddles[3], @@codes[3].rot(17)
        assert_equal "jelly", @@answers[3]
    end

    def test_riddle_chapter_4
        assert_equal @@riddles[4], @@codes[4].vigenere(@@answers[3])
        assert_equal "Steve Cooley", @@answers[4]
    end

    def test_riddle_chapter_5
        assert_equal @@riddles[5], @@codes[5].rot(5)
        assert_equal "Oroville", @@answers[5]
    end

    def test_riddle_chapter_6
        assert_equal @@riddles[6], @@codes[6].vigenere(@@answers[5])
        assert_equal "Hearts", @@answers[6]
    end

    def test_riddle_chapter_7
        assert_equal @@riddles[7], @@codes[7].rot(14)
        assert_equal "Bill Cook", @@answers[7]
    end

    def test_riddle_chapter_8
        assert_equal @@riddles[8], @@codes[8].vigenere(@@answers[7])
        assert_equal "150$", @@answers[8]
    end

    def test_riddle_chapter_9
        assert_equal @@riddles[9], @@codes[9].rot(11)
        assert_equal "firmware", @@answers[9]
    end

    def test_riddle_chapter_10
        assert_equal @@riddles[10], @@codes[10].vigenere(@@answers[9])
        assert_equal "Henry Spiegel", @@answers[10]
    end 

    def test_riddle_chapter_11
        assert_equal @@riddles[11], @@codes[11].rot(15)
        assert_equal "Calabasas", @@answers[11]
    end

    def test_riddle_chapter_12
        assert_equal @@riddles[12], @@codes[12].vigenere(@@answers[11])
        assert_equal "SAS", @@answers[12]
    end

    def test_riddle_chapter_13
        assert_equal @@riddles[13], @@codes[13].rot(3)
        assert_equal "Teltec", @@answers[13]
    end

    def test_riddle_chapter_14
        assert_equal @@riddles[14], @@codes[14].vigenere(@@answers[13])
        assert_equal "Village Market", @@answers[14]
    end

    def test_riddle_chapter_15
        assert_equal @@riddles[15], @@codes[15].rot(12)
        assert_equal "Optoelectronics", @@answers[15]
    end

    def test_riddle_chapter_16
        assert_equal @@riddles[16], @@codes[16].vigenere(@@answers[15])
        assert_equal "January 27", @@answers[16]
    end

    def test_riddle_chapter_17
        assert_equal @@riddles[17], @@codes[17].rot(8)
        assert_equal "Oakwood", @@answers[17]
    end

    def test_riddle_chapter_18
        assert_equal @@riddles[18], @@codes[18].vigenere(@@answers[17])
        assert_equal "WCC3", @@answers[18]
    end

    def test_riddle_chapter_19
        assert_equal @@riddles[19], @@codes[19].rot(21)
        assert_equal "Alphadent", @@answers[19]
    end

    def test_riddle_chapter_20
        assert_equal @@riddles[20], @@codes[20].vigenere(@@answers[19])
        assert_equal "Bob Burns", @@answers[20]
    end

    def test_riddle_chapter_21
        assert_equal @@riddles[21], @@codes[21].decode_hex.rot(13)
        assert_equal "Klingon", @@answers[21]
    end

    def test_riddle_chapter_22
        assert_equal @@riddles[22], @@codes[22].vigenere(@@answers[21])
        assert_equal "Kat", @@answers[22]
    end

    def test_riddle_chapter_23
        assert_equal @@riddles[23], @@codes[23].rot(9)
        assert_equal "boom box", @@answers[23]
    end

    def test_riddle_chapter_24
        assert_equal @@riddles[24], @@codes[24].vigenere(@@answers[23])
        assert_equal "Kinko", @@answers[24]
    end

    def test_riddle_chapter_25
        assert_equal @@riddles[25], @@codes[25].rot(6)
        assert_equal "Ellensburg", @@answers[25]
    end

    def test_riddle_chapter_26
        assert_equal @@riddles[26], @@codes[26].vigenere(@@answers[25])
        assert_equal "The Rockford Files", @@answers[26]
    end

    def test_riddel_27
        assert_equal @@riddles[27], @@codes[27].decode_decimal.rot(24)
        assert_equal "Tattered Cover", @@answers[27]
    end

    def test_riddle_chapter_28
        assert_equal @@riddles[28], @@codes[28].vigenere(@@answers[27])
        assert_equal "doc2", @@answers[28]
    end

    def test_riddle_chapter_29
        assert_equal @@riddles[29], @@codes[29].decode_octal.rot(25)
        assert_equal "snowbird", @@answers[29]
    end

    def test_riddle_chapter_30
        assert_equal @@riddles[30], @@codes[30].vigenere(@@answers[29])
        assert_equal "cylinder lock", @@answers[30]
    end

    def test_riddle_chapter_31
        assert_equal @@riddles[31], @@codes[31].rot(4)
        assert_equal "GTE Telenet", @@answers[31]
    end

    def test_riddle_chapter_32
        assert_equal @@riddles[32], @@codes[32].vigenere(@@answers[31])
        assert_equal "m00n$@earth", @@answers[32]
    end

    def test_riddle_chapter_33
        assert_equal @@riddles[33], @@codes[33].rot(18)
        assert_equal "Robert Morris", @@answers[33]
    end

    def test_riddle_chapter_34
        assert_equal @@riddles[34], @@codes[34].vigenere(@@answers[33])
        assert_equal "Direct link", @@answers[34]
    end

    def test_riddle_chapter_35
        assert_equal @@riddles[35], @@codes[35].decode_base36.rot(6)
        assert_equal "Players Club", @@answers[35]
    end

    def test_riddle_chapter_36
        assert_equal @@riddles[36], @@codes[36].vigenere(@@answers[35])
        assert_equal "Glasgow", @@answers[36]
    end

    def test_riddle_chapter_37
        assert_equal @@riddles[37], @@codes[37].decode_base64
        assert_equal "Kathleen Carson", @@answers[37]     
    end

    def test_riddle_chapter_38
        assert_equal @@riddles[38], @@codes[38].morse_normalize.morse
        assert_equal "FREE KEVIN", @@answers[38]
    end

    def debug_test_print_them_all
        @@answers.each_index do |i|
            puts @@codes[i]
            puts @@riddles[i]
            puts @@answers[i]
            puts
        end
    end

end