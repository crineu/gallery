
class Kevin
	attr_reader :phrase

	def initialize phrase
		@phrase = phrase
		@keys = {}
	end

	def keys=(new_keys)
		if new_keys.kind_of?(Hash)
			@keys = new_keys 
		else 
			new_keys.split(',').each do |pair|
				from = pair.split.first
				to   = pair.split.last

				(0...from.length).each { |i| @keys[from[i]] = to[i] }
			end
		end
	end

	def decypher
		final_sentence = ""
		@phrase.each_char do |char|
			new_char = @keys[char.downcase] || char
			new_char = new_char.upcase if (char == char.upcase)
			final_sentence += new_char
		end
		final_sentence
	end

	def print
		puts ":: " + @phrase
		puts "=> " + decypher
		puts		
	end
end

codes = []
File.readlines('chapter_codes').each do |line|
	chapter, code = line.split("\t")
	chapter = chapter.to_i
	codes[chapter] = Kevin.new(code)
end

# codes[1].keys = "yjcv what, ku is, pcog name, qh of, vjg the, uauvgo system, wugf used, da by, jco ham, vq to, ocmg make, htgg free, rjqpg phone, ecnu cals?"
codes[2].keys =  "wbth what, c i, poh but, voe our "
# codes[17].keys = ""

codes[1].print
codes[2].print
# codes[17].print

