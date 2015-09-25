require 'test/unit'

class TestTheTwelveDaysOfChristmas < Test::Unit::TestCase

    def count_gifts(gifts, day)
        gifts.tr('A ', '1 ').split("\n").pop(day).map(&:to_i).inject(:+)
    end

    def test_return
        sample = <<-EOF
        12 Drummers Drumming
        11 Pipers Piping
        10 Lords-a-Leaping
        9 Ladies Dancing
        8 Maids-a-Milking
        7 Swans-a-Swimming
        6 Geese-a-Laying
        5 Gold Rings
        4 Colly Birds
        3 French Hens
        2 Turtle Doves
        A Partridge in a Pear Tree.
        EOF

        assert_equal 55, count_gifts(sample, 10)
        assert_equal 1, count_gifts(sample, 1)
        assert_equal 3, count_gifts(sample, 2)
        assert_equal 10, count_gifts(sample, 4)
        assert_equal 21, count_gifts(sample, 6)
        assert_equal 78, count_gifts(sample, 12)
    end

end

