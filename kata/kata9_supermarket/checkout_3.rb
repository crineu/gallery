class Product
	attr_accessor :code, :price

	def subtotal quantity
		quantity * @price
	end
end

class ProductSale < Product
	attr_accessor :num_sale, :price_sale

	def subtotal quantity
		sub  = (quantity / @num_sale) * @price_sale
		sub += super(quantity % @num_sale)
		sub
	end
end

class CheckOut
	def initialize rules
		@rules = {}
		rules.each do |r|
			rule = r.strip.split

			if rule.size == 2
				product = Product.new
				product.code  = rule.shift
				product.price = rule.shift.to_i
			else rule.size > 0
				product = ProductSale.new
				product.code  = rule.shift
				product.price = rule.shift.to_i
				product.num_sale   = rule.shift.to_i
				product.price_sale = rule.pop.to_i
			end
			@rules[product.code]    = product
		end

		@buy_list = Hash.new { |hash, key| hash[key] = 0 }
	end

	def scan product_code
		@buy_list[product_code] += 1
	end

	def total
		total = 0
		@buy_list.each_pair do |code, qty|
			product = @rules[code]
			total += product.subtotal(qty)
		end
		total
	end
end
