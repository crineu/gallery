# Ruby Hash that returns no error, only empty hashes
# Based on http://firedev.com/posts/2015/bottomless-ruby-hash/


params = Hash.new({})
params[:world][:russia] = :moscow
params[:world][:thailand] = :bangkok

params[:underworld] = :hell

p params
p '-'
p params[:world][:russia]
p '-'
p params[:anything][:russia]

puts "\n --- \n"
# ----

params = Hash.new do |hash, key|
    hash[key] = Hash.new
end
params[:world][:thailand] = :bangkok
params[:underworld] = :hell

p params
puts "\n --- \n"

# ---
params = Hash.new { |h, k| h[k] = Hash.new(&h.default_proc) }

params[:world][:thailand][:bangkok][:bangna]
p params


# ---
# No matter how long the chain is, bottomless hash won't raise an error.
# Okay, it returns and empty hash instead of nil, which is truthy.
# But this can be checked with empty? even in plain ruby.
class BottomlessHash < Hash
  def initialize
    super &-> h, k { h[k] = self.class.new }
  end

  def self.from_hash(hash)
    new.merge(hash)
  end
end

puts "\n --- \n"
puts BottomlessHash.new[:bozo][:pedro_de_lara][:savana].empty? == true