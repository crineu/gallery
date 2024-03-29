require 'base64'

FLOOR = 97 	# a byte_code = 97
ROOF  = 122	# z byte_code = 122

class String
	def is_a_letter? byte_code
		(FLOOR..ROOF).include? byte_code
	end

	def rotate byte_code, distance
		if is_a_letter? byte_code
			distance = (distance + 26) % 26
			byte_code += distance
			byte_code = (byte_code % 123) + 97 if byte_code > ROOF
		end
		byte_code
	end

	# ROT algorithm
	def rot_encode distance
		bytes = self.downcase.each_byte.map { |byte_code| rotate(byte_code, distance) }
		# bytes.map { |byte| byte.chr }.join
		bytes.map(&:chr).join
	end

	def rot_decode distance
		rot_encode(-distance)
	end

	def print_all_rot
		(0..25).each { |n| puts n.to_s + ' - ' +  self.rot(n) }
	end

	# Vigenere algorithm
	def vigenere_encode key
		key_iterator = key.delete(' ').downcase.bytes.cycle
		code = String.new
		self.downcase.each_byte do |byte_code|
			distance = (key_iterator.next - FLOOR) if is_a_letter? byte_code
			code << rotate(byte_code, distance).chr
		end
		code
	end

	def vigenere_decode key
		key_iterator = key.delete(' ').downcase.bytes.cycle
		code = String.new
		self.downcase.each_byte do |byte_code|
			distance = -(key_iterator.next - FLOOR) if is_a_letter? byte_code
			code << rotate(byte_code, distance).chr
		end
		code
	end


	# Simple letter/symbol decoding
	def decode_decimal base=10
		self.split.map { |code| code.to_i(base).chr }.join
	end

	def decode_octal;  decode_decimal(8) end
	def decode_hex;    decode_decimal(16) end
	def decode_base36; decode_decimal(36) end
	
	def decode_base64; Base64.decode64(self) end

	# MORSE decoder
	@@morse_table = Hash[*%w/
		.- A	-... B	-.-. C
		-.. D	. E		..-. F
		--. G	.... H	.. I
		.--- J  -.- K	.-.. L
		-- M    -. N    --- O
		.--. P	--.- Q	.-. R
		... S	- T		..- U
		...- V	.-- W	-..- X
		-.-- Y	--.. Z	..--.. ?
	/]

	def morse_normalize
		self.gsub(" ", "   ").gsub("-", " ").gsub("0", "-").gsub("1", ".")
	end

	def morse_decode
		morse_words = self.split('   ')
		normal_words = morse_words.map{ |word| word.split.map{ |letter| @@morse_table[letter] }.join }
		normal_words.join(' ')
	end

	alias_method :rot, :rot_decode
	alias_method :vigenere, :vigenere_decode
	alias_method :morse, :morse_decode
end
