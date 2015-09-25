require 'test/unit'

class TestTheLicenceKeyChallenge < Test::Unit::TestCase

    def serial(string)
        h = '-'
        # string.dup.insert(20, '-').insert(15, '-').insert(10, '-').insert(5, '-')
        # 20.step(5, -5) { |n| string.insert(n, h) }
        # string

        string.scan(/.{5}/) * h
    end

    def test_return
        input  = "ABCDEFGHIJKLMNOPQRSTUVWXY"
        output = "ABCDE-FGHIJ-KLMNO-PQRST-UVWXY"

        assert_equal output, serial(input)
    end

end
