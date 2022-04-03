module HelperFile

  def self.file_to_array(file_name)
    array = []
    File.readlines(file_name).each do |line|
        chapter, text = line.split("\t")
        array[chapter.to_i] = text.chomp unless text.nil?
    end
    array
  end

end
