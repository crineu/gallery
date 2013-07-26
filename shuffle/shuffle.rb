class Shuffler
	def initialize card
		@card = card
		@results = Hash.new { |hash, key| hash[key] = 0 }
	end

	def naive_shuffle
		card = @card.dup
		card.size.times do |i|
			r = rand(card.size)
			card[i], card[r] = card[r], card[i]
		end
		card
	end

	def kfy_shuffle		# Knuth-Fisher-Yates shuffle algorithm.
		card = @card.dup
		(card.size - 1).downto 1 do |i|
			r = rand(i + 1)
			card[i], card[r] = card[r], card[i]
		end
		card
	end

	def analyze samples = 1_000
		# samples.times { @results[@card.shuffle] += 1 }	# API shuffle
		samples.times { @results[naive_shuffle] += 1 }		# naive shuffle
		# samples.times { @results[kfy_shuffle] += 1 }		# KFY shuffle

		puts "#{@card} shuffled #{samples} times."
		puts "-------------"
		@results.sort_by {|k, v| v}.each do |key, value|
			puts "#{key} - #{"|" * (value * 400 / samples)} (#{value * 100 / samples})%"
		end
	end

end

s = Shuffler.new [1, 2, 3]
s.analyze 10_000
