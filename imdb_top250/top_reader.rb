require_relative 'movie'

movies = {}
movies_array = []
File.open("top250_2015.txt").each_line do |line|
	movie = Movie.new line
	movies[movie.year] ||= []
	movies[movie.year] << movie

	movies_array << movie
end

years = movies.keys.sort
years.each do |year|
	# next if year < 1980

	movie_array = movies[year]
	# next if movie_array.size < 4

	puts "#{year} (#{movie_array.size}): " + movie_array.map{|m| m.name}.join(", ")
end

# Print movies ordered by most votes
# movies_array.sort {|a, b| b.votes <=> a.votes }.each {|movie| puts movie }

