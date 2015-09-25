# 124
# 00:12:37,000 --> 00:12:37,400
# [som do siscor sendo introduzido no recurso]

# 125
# 00:12:37,400 --> 00:12:37,800
# [som do expresso sendo introduzido no recurso]

# ...
# 14xxx
# 00:12:56,000 --> 00:12:48,000
# [som do revisa sendo introduzido no recurso]

# Durante um período definido, gera n subtitles

module Legendator
	@sistemas = %w(sgi siscop cvs mantis siscor archiva siape radio_serpro expresso garagens
		revisa speck speck gdes fenadados sindicato svpc sinort yes-break gdes rodízio miro)

	def self.generate start_time, end_time, step, first_number
		_start = start_time
		_end = end_time

		while (end_time - _start) > 0
			_end = _start + step

			puts first_number
			first_number += 1
			puts f(_start) + " --> " + f(_end)
			puts frase
			puts

			_start = _end
		end
	end

	def self.frase
		sistema = @sistemas.shuffle.shift
		"[som do #{sistema} fudendo o recurso]"
	end

	def self.f time
		"#{time.hour}:#{time.min}:#{time.sec},#{time.usec/1000}"
	end

end

_start = Time.local(2011, 01, 01, 0, 12, 37, 0)
_end   = Time.local(2011, 01, 01, 0, 12, 48, 0)
step = 0.4 		# segundos
first_number = 124

Legendator.generate _start, _end, step, first_number
