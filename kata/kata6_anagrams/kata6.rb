class Anagrams
	attr_reader :num_of_words

	def initialize file
		@num_of_words = IO.readlines(file).size
		@hash = Hash.new { |hash, key| hash[key] = [] }
		IO.readlines(file).each.map do |line| 
			word = line.strip
			key = word.downcase.each_byte.map.sort.to_s.to_i
			@hash[key] << word
		end
	end

	def num_of_anagrams_sets
		sets = 0
		@hash.values.each { |array| sets += 1 if array.size > 1 }

		sets
	end

	def print_all
		@hash.keys.each do |key|
			puts @hash[key].sort.join(", ")
		end
	end

	def print_sets(min_size = 1)
		@hash.keys.each do |key|
			puts @hash[key].join(", ") if @hash[key].size > min_size
		end
	end

end

