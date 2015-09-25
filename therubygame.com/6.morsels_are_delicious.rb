require "test/unit"

class TestMorse < Test::Unit::TestCase
	
	def morse_to_eng(morse)
		m = Hash[*%w/
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

		morse.split('   ').map{ |w| w.split.map{ |l| m[l] }.join }.join(' ')
	end

	def test_sample
		input = ".... . .-.. .--.   -- .   --- ..- -   --- ..-.   - .... .. ...   .-- . .-.. .-.."
		output = "HELP ME OUT OF THIS WELL"
		assert_equal output, morse_to_eng(input)
	end

	def test_shortest
		input = ".... . .-.. .--.   -- .   --- ..- -   --- ..-.   - .... .. ...   .-- . .-.. .-.."
		output = "HELP ME OUT OF THIS WELL"
		assert_equal output, morse_to_eng2(input)
	end

end
