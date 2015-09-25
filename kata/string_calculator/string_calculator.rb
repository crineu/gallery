module StringCalculator
	def add
		return 0 if empty?		
		raise_if_negative_numbers
		numbers.inject(:+)
	end

	def numbers
		@numbers ||= gsub("\n", delimiter).split(delimiter).map { |str| str.to_i }
	end

	def raise_if_negative_numbers
		negatives = numbers.select { |n| n < 0 }
		raise('Negatives not allowed: ' + negatives.join(', ')) if negatives.any?
	end

	def delimiter
		@delimiter ||= start_with?("//") ? self[2,1] : ','
	end
end

class String
	include StringCalculator
end