require 'base64'

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

	def decode_decimal base=10
		self.split.map { |code| code.to_i(base).chr }.join
	end

	def decode_octal; decode_decimal(8) end
	def decode_hex; decode_decimal(16) end
	def decode_base36; decode_decimal(36) end
	
	def decode_base64
		Base64.decode64(self)
	end

	@@morse = Hash[*%w/
		.- A	-... B	-.-. C
		-.. D	. E		..-. F
		--. G	.... H	.. I
		.--- J  -.- K	.-.. L
		-- M    -. N    --- O
		.--. P	--.- Q	.-. R
		... S	- T		..- U
		...- V	.-- W	-..- X
		-.-- Y	--.. Z
	/]
	def decode_morse
		self.split('   ').map{ |word| word.split.map{ |l| @@morse[l] }.join }.join(' ')
	end


end
