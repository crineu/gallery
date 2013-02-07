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

# struct FTW!
class Image
	attr_accessor :height, :width
	def initialize (array) 
		@height, @width = array.first, array.last
	end
	def to_s
		"#{@height}x#{@width}"
	end
end

result = []
folders = ['.'] + Dir.glob("**/*/")
folders.each do |folder|
	heights, widths = [], []
	files = Dir.entries(folder)
	files.reject! { |file| not ['.png', '.gif'].include? File.extname(file)  }
	files.map! { |file| folder + file } unless folder == '.'
	files.each do |filename|
		img = Image.new(size(filename))
		heights << img.height
		widths  << img.width
	end
	
	unless heights.empty?
		total_h = heights.reduce(:+)
		total_w = widths.reduce(:+)
		puts "*********"
		puts " Information for folder " + folder
		puts " Number of images: " + heights.size.to_s
		puts " Total / average height:   " + total_h.to_s + " / " + (total_h.to_f / heights.size).to_s
		puts " Total / average width:    " + total_w.to_s + " / " + (total_w.to_f / widths.size).to_s
		puts ""
	end
end
