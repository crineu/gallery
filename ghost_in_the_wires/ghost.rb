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

new_line = "\n"

puts codes[1].rot(2) + "==> autopatch" + new_line
puts codes[2].vigenere("autopatch") + "==> Sunset-Gower" + new_line
puts codes[3].rot(17) + "==> jelly" + new_line
puts codes[4].vigenere("jelly") + "==> Steve Cooley" + new_line
puts codes[5].rot(5) + "==> oroville" + new_line
puts codes[6].vigenere("oroville") + "==> hearts" + new_line
puts codes[7].rot(14) + "==> Bill Cook" + new_line
puts codes[8].vigenere("billcook") + "==> $150" + new_line
puts codes[9].rot(11) + "==> firmware" + new_line
puts codes[10].vigenere("firmware") + "==> Henry Spiegel" + new_line
puts codes[11].rot(15) + "==> calabasas" + new_line
puts codes[12].vigenere("calabasas") + "==> SAS" + new_line
puts codes[13].rot(3) + "==> teltec" + new_line
puts codes[14].vigenere("teltec") + "==> Village Market" + new_line
puts codes[15].rot(12) + "==> optoelectronics" + new_line
puts codes[16].vigenere("optoelectronics") + "==> January 27" + new_line
puts codes[17].rot(8) + "==> oakwood" + new_line
puts codes[18].vigenere("oakwood") + "==> WCC3" + new_line
puts codes[19].rot(21) + "==> alphadent" + new_line
puts codes[20].vigenere("alphadent") + "==> bob burns" + new_line



# codes[19].print_all_rot
