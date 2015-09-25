require 'kata_4_common'

class Team < EntityNameDiff
	alias :goals_diff :diff

	FILE = "football.dat"
	QUESTION = "Team with the smallest difference in ‘for’ and ‘against’ goals"

	def self.parse line
		tokens = line.split
		if tokens.first.to_i >= 1 and tokens.first.to_i <= 20
			team = Team.new(tokens[1], tokens[6], tokens[8])
		end
		team
	end

	def to_s
		"Team #{@name} with #{goals_diff} goals diff."
	end

end

EntityCollection.new.proccess Team