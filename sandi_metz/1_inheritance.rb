class House
  def recite
    (1..data.length).map { |i| line(i) }.join("\n")
  end

  def line(number)
    "This is #{phrase(number)}.\n"
  end

  def phrase(number)
    parts(number).join(" ")
  end

  def parts(number)
    data.last(number)
  end

  def data
    [ 'the horse and the hound and the horn that belonged to',
      'the farmer sowing his corn that kept',
      'the rooster that crowed in the morn that woke',
      'the judge all shaven and shorn that married',
      'the man all tattered and torn that kissed',
      'the maiden all forlorn that milked',
      'the cow with the crumpled horn that tossed',
      'the dog that worried',
      'the cat that killed',
      'the rat that ate',
      'the malt that lay in',
      'the house that Jack built' ]
  end
end

class RandomHouse < House
  def data
    @data ||= super.shuffle
  end
end

class EchoHouse < House
  def parts(number)
    super.zip(super).flatten
  end
end


h = EchoHouse.new

puts h.line 1
puts h.line 2
puts
puts h.recite
