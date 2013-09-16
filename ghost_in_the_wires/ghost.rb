FLOOR = 97 	# a byte_code = 97
ROOF  = 122	# z byte_code = 122

class String
	def letter? byte
		(FLOOR..ROOF).include? byte
	end

	def rot_encode gap
		bytes = self.downcase.each_byte.map { |byte| cycle(gap, byte) }
		bytes.map { |b| b.chr }.join
	end

	def rot gap
		rot_encode -gap
	end

	def print_all_rot
		(0..25).each { |n| puts n.to_s + ' - ' +  self.rot(n) }
	end

	def vigenere_encode key
		key_iterator = key.chars.cycle
		bytes = self.downcase.each_byte.map do |byte|
			gap = (key_iterator.next.ord - FLOOR) if letter? byte
			cycle(gap, byte)
		end
		bytes.map { |b| b.chr }.join
	end

	def vigenere key
		key_iterator = key.chars.cycle
		bytes = self.downcase.each_byte.map do |byte|
			gap = -(key_iterator.next.ord - FLOOR) if letter? byte
			cycle(gap, byte)
		end
		bytes.map { |b| b.chr }.join
	end

	def cycle gap, byte
		if letter? byte
			gap = (gap + 26) % 26
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

line = "\n"

puts codes[1] + codes[1].rot(2) + line
puts codes[2] + codes[2].vigenere("autopatch") + line
puts codes[3] + codes[3].rot(17) + line
puts codes[4] + codes[4].vigenere("jelly") + line
puts codes[5] + codes[5].rot(5) + line
puts codes[6] + codes[6].vigenere("oroville") + line
puts codes[7] + codes[7].rot(14) + line
puts codes[8] + codes[8].vigenere("billcook") + line
puts codes[9] + codes[9].rot(11) + line
puts codes[10] + codes[10].vigenere("firmware") + line

# codes[9].print_all_rot

