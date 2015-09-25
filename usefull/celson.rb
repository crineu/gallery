
_1 = %w{c ç s}
_2 = %w{e eh- é}
_3 = %w{l u}
_4 = %w{s ss ç}
_5 = %w{o oo oh}
_6 = %w{n m}

todos = []
_1.each do |a|
  _2.each do |b|
    _3.each do |c|
      _4.each do |d|
        _5.each do |e|
          todos << a + b + c + d + e
          _6.each do |f|
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