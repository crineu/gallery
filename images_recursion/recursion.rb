# black magic from web, so we don't need gems to read sizes, etc
def size(image_filename)
	if '.png' == File.extname(image_filename)
		return IO.read(image_filename)[0x10..0x18].unpack('NN')
	elsif '.gif' ==  File.extname(image_filename)
		return IO.read(image_filename)[6..10].unpack('SS')
	else
		return [10, 10]
	end
end

result = []
folders = ['.'] + Dir.glob("**/")
folders.each do |folder|
	heights, widths = [], []
	files = Dir.entries(folder)
	files.reject! { |file| not ['.png', '.gif'].include? File.extname(file)  }
	files.map! { |file| folder + file } unless folder == '.'
	files.each do |filename|
		size = size(filename)
		heights << size.first
		widths  << size.last
	end
	
	unless heights.empty?
		total_h = heights.reduce(:+)
		total_w = widths.reduce(:+)
		avg_h = total_h.to_f / heights.size
		avg_w = total_w.to_f / widths.size
		puts " Folder " + folder + " with this number of images: " + heights.size.to_s
		puts " Height: #{total_h}px (#{avg_h}) \tWidth: #{total_w}px (#{avg_w})"
		puts ""
	end
end
