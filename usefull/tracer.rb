require "benchmark"

module Tracer
  extend self

  def measure(klass)
    methods = klass.instance_methods(false)

    klass.class_eval do
      methods.each do |method|
        alias_method :"original_#{method}", method

        define_method(method) do |*args|
          Tracer.log_method_start(self.class.name, method, args)

          result = nil 

          duration = Benchmark.realtime do
            result = self.send(:"original_#{method}", *args)
          end 

          Tracer.log_method_end(self.class.name, method, result, duration)

          result
        end
      end
    end
  end

  def log_method_start(klass_name, method_name, arguments)
    puts "#{klass_name}##{method_name} called with arguments #{arguments.inspect}"
  end

  def log_method_end(klass_name, method_name, result, duration)
    puts "#{klass_name}##{method_name} took #{duration} and returned #{result.inspect}"
    puts "\n"
  end

end