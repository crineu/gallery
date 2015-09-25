require 'test/unit'
require 'checkout_3'

class TestPrice < Test::Unit::TestCase

	RULES = <<END
A     50    3 for 130
B     30    2 for 45
C     20
D     15    4 for 50
END

	def price(goods)
		checkout = CheckOut.new(RULES)
		goods.split(//).each { |item| checkout.scan(item) }
		checkout.total
	end

    def test_totals
		assert_equal   0, price("")
		assert_equal  50, price("A")
		assert_equal  80, price("AB")
		assert_equal 115, price("CDBA")

		assert_equal 100, price("AA")
		assert_equal 130, price("AAA")
		assert_equal 180, price("AAAA")
		assert_equal 230, price("AAAAA")
		assert_equal 260, price("AAAAAA")

		assert_equal 160, price("AAAB")
		assert_equal 175, price("AAABB")
		assert_equal 190, price("AAABBD")
		assert_equal 190, price("DABABA")
		assert_equal  65, price("DDDDD")
    end

    def test_incremental
		checkout = CheckOut.new(RULES)
		assert_equal(0, checkout.total)
		checkout.scan("A"); assert_equal  50, checkout.total
		checkout.scan("B"); assert_equal  80, checkout.total
		checkout.scan("A"); assert_equal 130, checkout.total
		checkout.scan("A"); assert_equal 160, checkout.total
		checkout.scan("B"); assert_equal 175, checkout.total
    end

end
