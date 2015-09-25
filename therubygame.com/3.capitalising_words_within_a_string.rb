require 'test/unit'

class TestCapitalisingWordsWithinAString < Test::Unit::TestCase
    def capitalize(string)
        string.split.map(&:capitalize).join(32.chr)
        # string.gsub /\w+/, &:capitalize
    end

    def test_sample
        input  = "The small brown & ginger fox JUMPED OVER the gate"
        output = "The Small Brown & Ginger Fox Jumped Over The Gate"

        assert_equal output, capitalize(input)

        # 25000.times { capitalize(input) }
    end

end

class TestCapitalisingWordsWithinAString2 < Test::Unit::TestCase
    def capitalize(string)
    end
    $upper = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    $down  = "abcdefghijklmnopqrstuvwxyz"
    def capitalize(string, uc=$upper, dc=$down)
        string.split.map{ |s| s[0].chr.tr(dc, uc) + s[1..-1].tr(uc, dc) } * ' '
    end

    def test_sample
        input  = "The small brown & ginger fox JUMPED OVER the gate"
        output = "The Small Brown & Ginger Fox Jumped Over The Gate"

        assert_equal output, capitalize(input)

        # 25000.times { capitalize(input) }
    end

end

