def index(file_for_read)
  File.foreach(file_for_read) {|user| puts user}
end