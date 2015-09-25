class Point
  attr_accessor :x, :y
  
  def initialize x, y
    @x, @y = x, y
  end
  
  def self.parse line
    x, y = line.split(" ")
    Point.new(x.to_i, y.to_i)
  end

  def to_s
    "#{@x},#{@y}"
  end
  
  def - p2
    x = p2.x - @x
    y = p2.y - @y
    Point.new(x.abs, y.abs)
  end
  
  def max_of p2
    Point.new([@x, p2.x].max, [@y, p2.y].max)
  end
  
  def max
    [@x, @y].max
  end

  def > p2
    self.max > p2.max 
  end
  
end

def distance_between_points points
  distances = []
  
  points_tail_cut = points.dup
  points_head_cut = points.dup

  points_tail_cut.pop
  points_head_cut.shift
  
  # Cria 2 arrays removendo 1o e ultimo elementos e interlaça-os
  points_tail_cut.zip(points_head_cut) do |p1, p2|
    distances <<  p1 - p2
  end
  distances
end

def max_diff lista_pontos
  lista_x = lista_pontos.map { |p| p.x } 
  lista_y = lista_pontos.map { |p| p.y }
  Point.new(lista_x.max - lista_x.min, lista_y.max - lista_y.min) 
end

# ainda não usa num_squares... mas deveria
def resolve points, num_squares, result = 1
  distances = distance_between_points points
  puts "k = #{num_squares}, points = #{points.join(", ")}" if DEBUG
  
  # Decide onde deve fazer o corte
  dist_x = distances.map { |p| p.x }
  dist_y = distances.map { |p| p.y }
  
  dist_x_max = dist_x.max
  dist_y_max = dist_y.max
  
  cut_index = dist_x.index(dist_x_max)
  cut_index = dist_y.index(dist_y_max) if dist_y_max > dist_x_max

  # Separa a lista de pontos em 'antes corte' e 'depois corte'
  tail = points.dup
  head = tail.shift(cut_index + 1)
  
  puts "\n head " + head.join(", ") if DEBUG
  puts " tail " + tail.join(", ") if DEBUG
  
  head_max_dist = max_diff head
  tail_max_dist = max_diff tail
    
  if num_squares > 2
    # escolhe o pior caso, head ou tail
    if tail_max_dist > head_max_dist
			result = [head_max_dist.max, result].max
			result = resolve(tail, num_squares - 1, result)
		else
			result = [tail_max_dist.max, result].max
			result = resolve(head, num_squares - 1, result)
		end

  else
    max_point = head_max_dist.max_of(tail_max_dist)
    puts " max point = #{max_point}\n" if DEBUG
    result = max_point.max
  end
  
  result
end

DEBUG = true

cases = gets.to_i
for i in 1..cases do
  n, k = gets.split(" ")
  n, k = n.to_i, k.to_i
  
  # Lê todos os pontos
  @@points = []
  n.times do
    @@points << Point.parse(gets)
  end
  
  puts "\n** case ##{i} n = #{n}, k = #{k} **\n" if DEBUG

  # Tem que ordernar por x, ver o resultado, depois por y e comparar os 2

  # Resolve o problema usando a ordenação por x
  @@points.sort!{ |p1, p2| p1.x <=> p2.x }
  x_result = resolve(@@points, k)

  # Resolve o problema, usando a ordenação por y
  @@points.sort!{ |p1, p2| p1.y <=> p2.y }
  y_result = resolve(@@points, k)
   
  puts "Result sorted by x = " + x_result.to_s if DEBUG
  puts "Result sorted by y = " + y_result.to_s if DEBUG
   
  # Pega o menor resultado achado através da ordenação entre por x e y
  puts "Case \##{i}: " + [x_result, y_result].min.to_s
  
end
