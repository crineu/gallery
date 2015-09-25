require 'kata_4_common'

class Weather < EntityNameDiff
	alias :day :name
	alias :spread :diff

	FILE = "weather.dat"
	QUESTION = "Day with the smallest temperature spread"

	def self.parse line
		tokens = line.split
		if tokens.first.to_i >= 1 and tokens.first.to_i <= 31
			weather = Weather.new(tokens[0], tokens[1], tokens[2])
		end
		weather
	end

	def to_s
		"Day #{day}, spread #{spread}"
	end

end

EntityCollection.new.proccess Weather