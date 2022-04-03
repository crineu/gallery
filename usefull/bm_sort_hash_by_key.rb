require 'benchmark'

arr = []
5000.times {
  arr << {:key => rand(1000)}
}

n = 500
Benchmark.bm(20) do |x|
  x.report("sort")               { n.times { arr.sort{ |a,b| b[:key] <=> a[:key] } } }
  x.report("sort reverse")       { n.times { arr.sort{ |a,b| a[:key] <=> b[:key] }.reverse } }
  x.report("sort_by -a[:key]")   { n.times { arr.sort_by{ |a| -a[:key] } } }
  x.report("sort_by a[:key]*-1") { n.times { arr.sort_by{ |a| a[:key]*-1 } } }
  x.report("sort_by.reverse!")   { n.times { arr.sort_by{ |a| a[:key] }.reverse } }
end
