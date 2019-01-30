require 'pathname'

pathname = Pathname.new(ARGV.first ||"/tmp/head_COTAHIST_A2018.TXT")

bovespa_code  = "A2"
bovespa_code += "A8"
bovespa_code += "A2"
bovespa_code += "A12"
bovespa_code += "A3"
bovespa_code += "A12"
bovespa_code += "A10"
bovespa_code += "A3"
bovespa_code += "A4"
7.times { bovespa_code += "A13" }
bovespa_code += "A5"
bovespa_code += "A18"
bovespa_code += "A18"
bovespa_code += "A13"
bovespa_code += "A1"
bovespa_code += "A8"
bovespa_code += "A7"
bovespa_code += "A13"
bovespa_code += "A12"
bovespa_code += "A3"

_2decimal = [9,10,11,12,13,14,15,18,19]
_6decimal = [23]

File.open(pathname.sub_ext('.CSV'), File::CREAT|File::RDWR) do |csv|
  File.readlines(pathname).each do |line|
    next unless line.start_with? '01'
    array = line.unpack(bovespa_code)
    _2decimal.each { |i| array[i].insert(-3, ',') }
    _6decimal.each { |i| array[i].insert(-7, ',') }
    csv.puts array.join('#')
  end
end

puts "\n\t-----------"
puts "\t#{pathname.basename} done!"
puts "\n"



###### testes
# sample = "012003021202VALE5       010VALE R DOCE PNA          R$  000000001000000000000100800000000009820000000000991800000000098200000000009701000000000982000306000000000000230500000000002286139000000000000000009999123100000010000000000000BRVALEACNPA3160"

# arr = sample.unpack(bovespa_code)
# p arr

# # a = "9876543210987"
# # p a
# # p a[0..-3] + ',' + a[-2,2]