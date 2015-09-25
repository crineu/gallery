module ChopperWhile
	def chop int, array
		result = -1
		min, max = 0, array.size - 1

		while max >= min and result == -1
			middle = (max + min) / 2
			middle_man = array[middle]

			if int == middle_man
				result = middle
			elsif int > middle_man
				min = middle + 1
			elsif int < middle_man
				max = middle - 1
			end
		end
		result
	end	
end

module ChopperRecursive2
	def chop int, array
		return -1 if array.nil? or array.empty?
		middle_index = array.size / 2
		middle_man = array[middle_index]

		result = nil
		if int == middle_man
			result = middle_index
		elsif int > middle_man
			upper_half = array[(middle_index + 1)...array.size]
			result = chop(int, upper_half)
			result += middle_index + 1 if result != -1
		elsif int < middle_man
			lower_half = array[0...middle_index]
			result = chop int, lower_half
		end
		result
	end
end

module ChopperRecursive
	def chop int, array
		@target, @array = int, array
		chop_recursive 0, array.size - 1
	end

	def chop_recursive min, max
		return -1 if max < min
		middle_index = (max + min) / 2
		middle_element = @array[middle_index]

		result = nil
		if @target == middle_element
			result = middle_index
		elsif @target > middle_element
			result = chop_recursive middle_index + 1, max
		elsif @target < middle_element
			result = chop_recursive min, middle_index - 1
		end
		result
	end
end

module ChopperThreads
	def chop int, array
		@target, @array = int, array
		@result, @threads = -1, []
		
		chop_recursive 0, array.size - 1

		@threads.each { |t| t.join }
		@result
	end

	def chop_recursive min, max
		if min == max # one element to check
			@result = min if @target == @array[min]
		elsif max >= min and # valid range
			@target <= @array[max] and # @target inside range
			@target >= @array[min]

			# divide array, launch one thread for each half
			middle = (max + min) / 2
			@threads << Thread.new { chop_recursive min, middle }
			@threads << Thread.new { chop_recursive middle + 1, max }
		end		
	end
end

class Chopper
	extend ChopperWhile
end