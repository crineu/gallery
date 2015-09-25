require 'test/unit'

class PunsPalindromesAndParrotes < Test::Unit::TestCase

    def longestPalindrome(string)
        word_length = string.size
        word_length.downto(2) do |piece_length|
            (word_length - piece_length + 1).times do |initial_gap|
                piece = string.slice(initial_gap, piece_length)
                return piece if piece == piece.reverse
            end
        end
        return ""
    end

    def test_sample
        input  = "abacdfgdcabaypqqpy"
        output = "ypqqpy"

        assert_equal output, longestPalindrome(input)
    end

end
