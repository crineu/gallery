
class LazyClass

  def hello
    puts "todo o calculo do mundo..."
    @resp = 52 *81  / 25.6 -92 /9 *2
    def hello
      puts "so responde"
      @resp
    end
    @resp
  end

end

l = LazyClass.new
5.times { puts l.hello }