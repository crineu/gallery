require 'test/unit'

class RomanNumerals < Test::Unit::TestCase

    # my solution
    def to_arabic_numeral_ORIGINAL(roman)
        values = {'I' => 1, 'V' => 5, 'X' => 10, 'L' => 50, 'C' => 100, 'D' => 500, 'M' => 1000}
        
        array = roman.chars

        number = 0;
        while array.any?
            head = array.shift
            if array.any? and head < array.first
                head = array.shift - head
            end
            number += head
        end
        number
    end

    # in the shortest list
    def to_arabic_numeral(roman)
        number = sum = 0
        roman.bytes do |char| 
            sum += number - 2 * number % number = 10 ** (205558 % char % 7) % 9995
        end
        sum + number
    end

    # from rubyquiz
    def to_arabic_numeral_COLA(roman)
        @data = [
            ["M", 1000], ["CM", 900],
            ["D",  500], ["CD", 400],
            ["C",  100], ["XC",  90],
            ["L",   50], ["XL",  40],
            ["X",   10], ["IX",   9],
            ["V",    5], ["IV",   4],
            ["I",    1]
        ]

        reply = 0
        for letter, value in @data
            while roman.index(letter) == 0
                reply += value
                roman.slice!(letter)
            end
        end
        reply
    end

    ########## TESTS ##########
    def test_sample
        input  = "MCMXCIX"
        output = 1999
        assert_equal output, to_arabic_numeral(input)
    end

    def test_only_sum
        assert_equal 1, to_arabic_numeral('I')
        assert_equal 2, to_arabic_numeral('II')
        assert_equal 5, to_arabic_numeral('V')
        assert_equal 10, to_arabic_numeral('X')
        assert_equal 10, to_arabic_numeral('X')
        assert_equal 15, to_arabic_numeral('XV')
        assert_equal 25, to_arabic_numeral('XXV')
        assert_equal 25, to_arabic_numeral('XXV')

        assert_equal 50, to_arabic_numeral('L')
        assert_equal 100, to_arabic_numeral('C')
        assert_equal 500, to_arabic_numeral('D')
        assert_equal 1000, to_arabic_numeral('M')
    end

    def test_sum_subtraction
        assert_equal 4, to_arabic_numeral('IV')
        assert_equal 9, to_arabic_numeral('IX')
        assert_equal 99, to_arabic_numeral('XCIX')
    end

end