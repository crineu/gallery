def fat(x)
    fffffat = 1
    while (x > 1)
        fffffat *= x
        x = x -1
    end
    fffffat
end

def fat2(x)
    return x == 1 ? 1 : x*fat(x-1)
end

def fat3(n)
    (2..n).inject { |r, n| r *= n }
end

def now
    time = Time.now
    "#{time.hour}:#{time.min}:#{time.sec}"
end

numma = 98777

puts now
fat(numma)
puts now
fat2(numma)
puts now
fat3(numma)
puts now
