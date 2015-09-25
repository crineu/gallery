class EntityNameDiff
	attr_reader :name, :diff

	def initialize name, value_1, value_2
		@name = name
		@diff = (value_1.to_i - value_2.to_i).abs
	end

	def <=> another_entity
		@diff <=> another_entity.diff
	end

end

class EntityCollection
	attr_accessor :list

	def proccess klass
		@klass = klass
		read_file
		print_result
	end

	private
	def read_file
		@list = []
		IO.readlines(@klass::FILE).each do |line| 
			@list << @klass.parse(line)
		end
		@list.compact!.sort!
	end

	def print_result
		puts "Q: " + @klass::QUESTION
		puts "A: " + @list.first.to_s
	end

end
