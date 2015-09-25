class CheckOut

	def initialize rules
		@rules = {}
		rules.each do |line|
			tokens = line.strip.split
			price = []
			
			product		= tokens.shift
			price[1]	= tokens.shift.to_i
			if tokens.size == 3
				promo_n		= tokens.shift.to_i
				promo_price	= tokens.pop.to_i
				price[promo_n] = promo_price
			end

			@rules[product] = price
		end
		@products = Hash.new { |hash, key| hash[key] = 0 }
	end

	def scan item
		@products[item] += 1
	end

	def total
		total = 0
		@products.each_pair do |code, quantity|
			subtotal = product_price(code, quantity)
			total = total + subtotal
		end

		total
	end

	def product_price code, quantity
		subtotal = 0
		qty_left = quantity

		prices_array = @rules[code]
		index = qty_left
		while qty_left > 0 and index > 0
			if prices_array[index]
				subtotal += prices_array[index]
				qty_left = qty_left - index
				index = qty_left
			else
				index = index - 1
			end
		end

		subtotal
	end

end
