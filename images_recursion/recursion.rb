# black magic from web, so we don't need gems to read sizes, etc
def size(image_filename)
	if '.png' == File.extname(image_filename)
		return IO.read(image_filename)[0x10..0x18].unpack('NN')
	elsif '.gif' ==  File.extname(image_filename)
		return IO.read(image_filename)[6..10].unpack('SS')
	end
end

# struct FTW!
class Image
	attr_accessor :height, :width
	def initialize (array)
		@height, @width = array.first, array.last
	end
end

result = []
folders = ['.'] + Dir.glob("**/*/")
folders.each do |folder|
	r_folders = []
	files = Dir.entries(folder)
	files.reject! { |file| not ['.png', '.gif'].include? File.extname(file)  }
	files.each do |filename|
		img = Image.new(size(folder + filename))
		r_folders << img
	end
	p r_folders
end
