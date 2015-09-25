require 'digest/sha1'

FILE = 'words_A'
#DIC_SIZE = 275_502
BITMAP_SIZE = 500
HASH_FUNCTIONS = 6

class Hashable
	attr_reader :hash

	def initialize string
		create_hashes string
	end

	def create_hashes string
		digest = Digest::SHA1.hexdigest string.upcase
		digest.gsub!(/\D/, '')	# remove letters

		@hash = Array.new(HASH_FUNCTIONS, 0)
		HASH_FUNCTIONS.times do |i|
			@hash[i] = digest.to_i << (i+1)
		end
	end
end

class BloomFilter
	def initialize
		@bitMap = Array.new(BITMAP_SIZE, false)
	end

	def load_all
		IO.readlines(FILE).each do |line| 
			add line.strip 
		end

		soma = 0
		@bitMap.each { |value| soma += 1 if value }
		puts 'Bits usados: ' + ("%d" % soma) + ' de ' + BITMAP_SIZE.to_s
	end

	def add word
		Hashable.new(word).hash.each do |index|
			@bitMap[index % BITMAP_SIZE] = true
		end
	end

	def has word
		contains_word = true
		Hashable.new(word).hash.each do |index|
			contains_word &= @bitMap[index % BITMAP_SIZE]
		end
		contains_word
	end
end

class Dictionary
	def load_all
		@words = []
		IO.readlines(FILE).each { |line| @words << line.strip }
	end

	def has word
		not @words.index(word).nil?
	end
end


#puts Hashable.new("cavalo").hash.join(", ")
