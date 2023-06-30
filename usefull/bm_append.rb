require 'benchmark'
require 'json'

values = <<JSON
JSON

json1 = JSON.parse(values)
json2 = JSON.parse(values)
json3 = JSON.parse(values)

str1, str2, str3 = "", "", ""

n = 2
Benchmark.bm(16) do |x|
  x.report("string") {
    n.times {
      json1.each { |e| str1 += "<option value=\"#{e["cnes"]}\">#{e["name"]}</option>" }
    }
  }
  x.report("map/join") {
    n.times {
      str2 = json2.map { |e| "<option value=\"#{e["cnes"]}\">#{e["name"]}</option>" }.join('')
    }
  }
  x.report("array <<") {
    n.times {
      ary = []
      json3.each { |e|
        ary << "<option value=\""
        ary << e["cnes"]
        ary << "\">"
        ary << e["name"]
        ary << "</option>"
      }
      str3 = ary.join('')
    }
  }
end

puts "\n\n"
puts "\t=> string   == map/join?  #{(str1 == str2).to_s.upcase}"
puts "\t=> array << == map/join?  #{(str2 == str3).to_s.upcase}"