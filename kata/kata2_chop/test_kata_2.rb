require 'test/unit'
require File.dirname(__FILE__) + '/kata_2.rb'

class TestKataTwoChop < Test::Unit::TestCase
    
    def test_chop_small_array
        assert_equal(-1, Chopper.chop(3, []))
        assert_equal(-1, Chopper.chop(3, [1]))
        assert_equal(0,  Chopper.chop(1, [1]))
    end
    
    def test_chop_135
        assert_equal(0,  Chopper.chop(1, [1, 3, 5]))
        assert_equal(1,  Chopper.chop(3, [1, 3, 5]))
        assert_equal(2,  Chopper.chop(5, [1, 3, 5]))
        assert_equal(-1, Chopper.chop(0, [1, 3, 5]))
        assert_equal(-1, Chopper.chop(2, [1, 3, 5]))
        assert_equal(-1, Chopper.chop(4, [1, 3, 5]))
        assert_equal(-1, Chopper.chop(6, [1, 3, 5]))
    end
    
    def test_chop_1357
        assert_equal(0,  Chopper.chop(1, [1, 3, 5, 7]))
        assert_equal(1,  Chopper.chop(3, [1, 3, 5, 7]))
        assert_equal(2,  Chopper.chop(5, [1, 3, 5, 7]))
        assert_equal(3,  Chopper.chop(7, [1, 3, 5, 7]))
        assert_equal(-1, Chopper.chop(0, [1, 3, 5, 7]))
        assert_equal(-1, Chopper.chop(2, [1, 3, 5, 7]))
        assert_equal(-1, Chopper.chop(4, [1, 3, 5, 7]))
        assert_equal(-1, Chopper.chop(6, [1, 3, 5, 7]))
        assert_equal(-1, Chopper.chop(8, [1, 3, 5, 7]))
    end
    
    def test_chop_medium_input
        list = %w(1 4 5 6 7 8 12 13 15 18 20 22 24 25 29 31 32 35 40 44 45 46 48 50 51 53 60 70 80 88 90 99)
        list.map! { |string| string.to_i }
        assert_equal(0, Chopper.chop(1, list))
        assert_equal(list.index(99), Chopper.chop(99, list))
        assert_equal(list.index(32), Chopper.chop(32, list))
    end
end
