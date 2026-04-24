
l_1 = %w{c ç s}
l_2 = %w{e eh- é}
l_3 = %w{l u}
l_4 = %w{s ss ç}
l_5 = %w{o oo oh}
l_6 = %w{n m}

todos = []
l_1.each do |a|
  l_2.each do |b|
    l_3.each do |c|
      l_4.each do |d|
        l_5.each do |e|
          todos << a + b + c + d + e
          l_6.each do |f|
            todos << a + b + c + d + e + f
          end
        end
      end
    end
  end
end

todos.shuffle!
puts todos.join(", ")
puts todos.size
