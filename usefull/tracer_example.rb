class Dog
  attr_writer :name

  def initialize(name)
    @name = name
  end

  def bark
    puts "patrick"
  end
end



require_relative "tracer"

# turn on method tracing for every Dog instance
Tracer.measure(Dog)

dog = Dog.new("sparky")

dog.name = "patrick"
dog.bark
