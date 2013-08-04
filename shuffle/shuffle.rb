class Array
	def naive_shuffle
		card = self.dup
		card.size.times do |iterator|
			random = rand(card.size)
			card[iterator], card[random] = card[random], card[iterator]
		end
		card
	end

	def kfy_shuffle		# Knuth-Fisher-Yates shuffle algorithm.
		card = self.dup
		(card.size - 1).downto 1 do |iterator|
			random = rand(iterator + 1)
			card[iterator], card[random] = card[random], card[iterator]
		end
		card
	end

	def double_array_shuffle
		card = self.dup
		new_card = Array.new
		while not card.empty?
			new_card << card.delete_at(rand(card.size))
		end
		new_card
	end
end

class Shuffler
	def initialize card
		@card = card
	end

	def analyze_naive samples
		@results = Hash.new { |hash, key| hash[key] = 0 }
		@samples = samples
		@samples.times { @results[@card.naive_shuffle] += 1 }	# naive shuffle
		print_results
	end

	def analyze_kfy samples
		@results = Hash.new { |hash, key| hash[key] = 0 }
		@samples = samples
		# @samples.times { @results[@card.shuffle] += 1 }	# API shuffle
		@samples.times { @results[@card.kfy_shuffle] += 1 }		# KFY shuffle
		print_results
	end

	def analyze_shift samples
		@results = Hash.new { |hash, key| hash[key] = 0 }
		@samples = samples
		@samples.times { @results[@card.double_array_shuffle] += 1 }		# KFY shuffle
		print_results
	end

	private
	def print_results
		max_value = @results.values.max
		longest_bar = 40
		
		puts "#{@card} shuffled #{@samples} times."
		puts "-------------"
		@results.sort_by {|k, v| v}.each do |key, value|
			bar = "|" * (value * longest_bar / max_value)
			puts "#{key} - #{bar} (#{value * 100 / @samples}%)"
		end
		puts "\n" 
	end
end

n_samples = 100_000
s = Shuffler.new [1, 2, 3]
s.analyze_naive n_samples
s.analyze_kfy n_samples
s.analyze_shift n_samples
