FILE_PATH = "./Files_txt/students.txt"
RESULTS = "./Files_txt/results.txt"

def index
  File.foreach(FILE_PATH) { |element| puts element}
end

while true
puts "Enter the age of students to add: "
age_students = gets.chomp.to_s

if age_students == "-1" || File.size(FILE_PATH) == File.size(RESULTS)
  break
end

file = File.open(RESULTS, "a")
File.foreach(FILE_PATH){ |student| file.puts(student) if student.include?(age_students) }

file.close
end









