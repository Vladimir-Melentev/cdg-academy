FILE_PATH = "./Files_txt/students.txt"
RESULTS = "./Files_txt/results.txt"

def index
  File.foreach(FILE_PATH) { |element| puts element}
end

index