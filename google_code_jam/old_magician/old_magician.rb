cases = gets.to_i

for i in 1..cases do
	w, b = gets.split(" ")
	answer = "Case \##{i}: "

	if b.to_i % 2 == 0 
		answer += 'WHITE'
	else
		answer += 'BLACK'
	end
	puts answer
end
