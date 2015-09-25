require 'test/unit'
require_relative 'procs.rb'

class TestProcs < Test::Unit::TestCase

    # NUMBERS
    def to_integer(proc)
        proc[lambda { |n| n + 1 }][0]
    end

    def test_integer
        assert_equal 0,   to_integer(ZERO)
        assert_equal 1,   to_integer(ONE)
        assert_equal 3,   to_integer(THREE)
        assert_equal 5,   to_integer(FIVE)
        assert_equal 15,  to_integer(FIFTEEN)
        assert_equal 100, to_integer(HUNDRED)
    end

    # BOOLEANS
    def to_boolean(proc)
        IF[proc][true][false]
    end

    def test_boolean
        assert  to_boolean(TRUE_)
        assert !to_boolean(FALSE_)
    end

    def test_if
        assert_equal :foo, IF[TRUE_][:foo][:bar]
        assert_equal :bar, IF[FALSE_][:foo][:bar]
    end

    # PREDICATES
    def test_if_zero
        assert  to_boolean(IS_ZERO[ZERO])
        assert !to_boolean(IS_ZERO[THREE])
    end

    # NUMERIC OPERATIONS
    def test_numeric_operations
        assert_equal 2, to_integer(INCREMENT[ONE])
        assert_equal 3, to_integer(INCREMENT[TWO])

        assert_equal 1, to_integer(DECREMENT[TWO])
        assert_equal 4, to_integer(DECREMENT[FIVE])
    end

    def test_other_numeric_operations
        assert_equal 3,   to_integer(ADD[ONE][TWO])
        assert_equal 5,   to_integer(SUBTRACT[TEN][FIVE])
        assert_equal 15,  to_integer(MULTIPLY[THREE][FIVE])
        assert_equal 100, to_integer(POWER[TEN][TWO])
    end

    def test_less_or_equal
        assert  to_boolean(IS_LESS_OR_EQUAL[ONE][TWO])
        assert  to_boolean(IS_LESS_OR_EQUAL[TWO][TWO])
        assert !to_boolean(IS_LESS_OR_EQUAL[THREE][TWO])
    end

    def test_mod
        assert_equal 1, to_integer(MOD[THREE][TWO])
        assert_equal 2, to_integer(MOD[POWER[THREE][THREE] ][ADD[THREE][TWO]])
    end

    # LISTS
    def to_array(proc)
        array = []
        until to_boolean(IS_EMPTY[proc])
            array.push(FIRST[proc])
            proc = REST[proc]
        end
        array
    end

    def test_pairs
        my_pair = PAIR[THREE][FIVE]
        assert_equal 3, to_integer(LEFT[my_pair])
        assert_equal 5, to_integer(RIGHT[my_pair])
    end

    def test_list
        my_list =
            UNSHIFT[
                UNSHIFT[
                    UNSHIFT[EMPTY][THREE]
               ][TWO]
            ][ONE]

        assert_equal 1, to_integer(FIRST[my_list])
        assert_equal 2, to_integer(FIRST[REST[my_list]])
        assert_equal 3, to_integer(FIRST[REST[REST[my_list]]])
        assert !to_boolean(IS_EMPTY[my_list])
        assert  to_boolean(IS_EMPTY[EMPTY])

        # to_array(my_list)
        assert_equal [1,2,3], to_array(my_list).map { |p| to_integer(p) }
    end

    def test_range
        my_range = RANGE[ONE][FIVE]
        assert_equal [1, 2, 3, 4, 5], to_array(my_range).map { |p| to_integer(p) }
    end

    def test_fold
        assert_equal 15,  to_integer(FOLD[RANGE[ONE][FIVE]][ZERO][ADD])
        assert_equal 120, to_integer(FOLD[RANGE[ONE][FIVE]][ONE][MULTIPLY])
    end

    def test_map
        my_list = MAP[RANGE[ONE][FIVE]][INCREMENT]
        assert_equal [2, 3, 4, 5, 6], to_array(my_list).map { |p| to_integer(p) }
    end

    # STRINGS
    def to_char(c)
        '0123456789BFiuz'.slice(to_integer(c)).chr
    end

    def to_string(s)
        to_array(s).map { |c| to_char(c) }.join
    end

    def test_to_char
        assert_equal "z", to_char(ZED)
    end

    def test_to_string
        assert_equal "FizzBuzz", to_string(FIZZBUZZ)
    end

    def test_to_digits
        assert_equal [5], to_array(TO_DIGITS[FIVE]).map { |p| to_integer(p) }
        # assert_equal [1, 2, 5], to_array(TO_DIGITS[POWER[FIVE][THREE]]).map { |p| to_integer(p) }
        assert_equal [1, 0, 0], to_array(TO_DIGITS[HUNDRED]).map { |p| to_integer(p) }
    end

    def test_to_strings
        assert_equal "5", to_string(TO_DIGITS[FIVE])
        # assert_equal "125", to_string(TO_DIGITS[POWER[FIVE][THREE]])
    end

    def test_fizz_buzz
        fizz = MAP[RANGE[ONE][HUNDRED]][lambda { |n|
            IF[ IS_ZERO[MOD[n][FIFTEEN]] ][
                FIZZBUZZ
            ][IF[ IS_ZERO[MOD[n][THREE]] ][
                FIZZ
            ][IF[ IS_ZERO[MOD[n][FIVE]] ][
                BUZZ
            ][
                TO_DIGITS[n]
            ]]]
        }]

        puts to_array(fizz).map { |p| to_string(p) }
    end

end
