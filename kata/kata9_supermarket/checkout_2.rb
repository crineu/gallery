
class Product
	def initialize price, promo_n=999_999, promo_price=0
		@price = price
		@promo_n, @promo_price = promo_n, promo_price
	end

	def subtotal num_items
		promo_itens, normal_itens = num_items.divmod(@promo_n)
		# 7.divmod 2 => [3, 1]
		
		subtotal = 0
		subtotal += promo_itens * @promo_price
		subtotal += normal_itens * @price
		subtotal
	end
end

class CheckOut

	def initialize rules
		@products = {}
		rules.each do |line|
			tokens = line.strip.split
			
			code		= tokens.shift
			unit_price	= tokens.shift.to_i
			product = Product.new unit_price
			if tokens.size == 3
				promo_n		= tokens.shift.to_i
				promo_price	= tokens.pop.to_i
				
				product = Product.new unit_price, promo_n, promo_price
			end

			@products[code] = product
		end
		@itens_list = Hash.new { |hash, key| hash[key] = 0 }
	end

	def scan code
		@itens_list[code] += 1
	end

	def total
		total = 0
		@itens_list.each_pair do |code, num_items|
			total += @products[code].subtotal(num_items)
		end

		total
	end

end
