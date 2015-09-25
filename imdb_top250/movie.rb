# input sample:
#214.	8.0	Ed Wood (1994)	79,481
# position \t score name (year) votes 

class Movie
	attr_reader :position, :score, :name, :year, :votes
	
	def initialize input
		attributes = input.split("\t")
		
		@position = attributes[0].to_i
		@score = attributes[1].to_f
		@votes = attributes[3].delete(",").to_i
		
		name_year = attributes[2].split("(")
		@name = name_year[0].strip
		@year = name_year[1].to_i
	end
	
	def to_s
		"#{@position} [#{@score}]: #{@name} (#{@year}) #{@votes} votes"
	end
end
