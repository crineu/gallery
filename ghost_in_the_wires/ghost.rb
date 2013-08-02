FLOOR = 97 	# a byte_code = 97
ROOF  = 122	# z byte_code = 122

class String
	def rot_encode gap
		gap = (gap + 26) % 26
		bytes = self.downcase.each_byte.map { |byte| cycle(gap, byte) }
		bytes.map { |b| b.chr }.join
	end

	def rot gap
		rot_encode -gap
	end

	def vigenere_encode key
		key_iterator = key.chars.cycle
		bytes = self.downcase.each_byte.map do |byte|
			gap = (key_iterator.next.ord - FLOOR)
			gap = (gap + 26) % 26
			cycle(gap, byte)
		end
		bytes.map { |b| b.chr }.join
	end

	def cycle gap, byte
		if byte >= FLOOR and byte <= ROOF 
			byte += gap
			byte = (byte % 123) + 97 if byte > ROOF
		end
		byte
	end
end


codes = []
File.readlines('chapter_codes').each do |line|
	chapter, code = line.split("\t")
	codes[chapter.to_i] = code
end

puts codes[1]
puts codes[1].rot(2) # autopatch
