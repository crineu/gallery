SOURCE = ARGV.first ||"/tmp/DemoCotacoesHistoricas12022003.txt"

code = "A2"
code += "A8"
code += "A2"
code += "A12"
code += "A3"
code += "A12"
code += "A10"
code += "A3"
code += "A4"
7.times { code += "A13" }
code += "A5"
code += "A18"
code += "A18"
code += "A13"
code += "A1"
code += "A8"
code += "A7"
code += "A13"
code += "A12"
code += "A3"

_two_decimals = [9,10,11,12,13,14,15,18,19]
_six_decimals = [23]


output = File.open(SOURCE[0..-4] + "csv", File::CREAT|File::RDWR)

File.readlines(SOURCE).each do |line|
    next unless '01' == line[0,2]
    arr = line.unpack(code)
    _two_decimals.each { |i| arr[i] = arr[i][0..-3] +','+ arr[i][-2,2] }
    _six_decimals.each { |i| arr[i] = arr[i][0..-7] +','+ arr[i][-6,6] }
    output.puts arr.join('#')
end

output.close
puts "done #{SOURCE}"



###### testes
# sample = "012003021202VALE5       010VALE R DOCE PNA          R$  000000001000000000000100800000000009820000000000991800000000098200000000009701000000000982000306000000000000230500000000002286139000000000000000009999123100000010000000000000BRVALEACNPA3160"

# arr = sample.unpack(code)
# p arr

# # a = "9876543210987"
# # p a
# # p a[0..-3] + ',' + a[-2,2]