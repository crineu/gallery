# a byte_code = 97
# z byte_code = 122

class String
	def rot gap
		gap = (gap + 26) % 26
		bytes = self.downcase.each_byte.map { |byte| cycle(gap, byte)}
		bytes.map { |b| b.chr }.join
	end

	def rot_decode gap
		rot -gap
	end

	def cycle gap, byte
		if byte > 96 and byte < 123
			byte += gap
			byte = (byte % 123) + 97 if byte > 122
		end
		byte
	end
end

class Ghost
	def self.vigenere key, sentence
	end
end

codes = []
File.readlines('chapter_codes').each do |line|
	chapter, code = line.split("\t")
	codes[chapter.to_i] = code
end

puts codes[1]
puts codes[1].rot_decode(2)