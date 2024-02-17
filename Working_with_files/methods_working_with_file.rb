FILE_PATH = "./Files_txt/students.txt"
BUFFER = "./Files_txt/buffer.txt"

def index
  File.foreach(FILE_PATH) { |element| puts element}
end

def find(id)
  File.foreach(FILE_PATH).with_index do |element, index|
    @element_id = index if element.include?(id)
  end

  @element_id
  puts "Line number #{@element_id + 1}"
end

def where(pattern)
  patt_arr = []

  File.foreach(FILE_PATH).with_index do |element, index|
    patt_arr << index if element.include?(pattern)
  end

  patt_arr
end

def update(id, text)
  file = File.open(BUFFER, "w")

  File.foreach(FILE_PATH).with_index do |element, index|
    file.puts(id  == index ? text : element)
  end

  file.close

  File.write(FILE_PATH, File.read(BUFFER))
  File.delete(BUFFER) if File.exist?(BUFFER)
end

def delete(id)
  file = File.open(BUFFER, "w")

  File.foreach(FILE_PATH).with_index do |element, index|
    file.puts(id  == index ? nil : element)
  end

  file.close

  File.write(FILE_PATH, File.read(BUFFER))
  File.delete(BUFFER) if File.exist?(BUFFER)
end

def create(name)
  File.open(FILE_PATH, "a") {|element| element.puts("\n#{name}") }
end