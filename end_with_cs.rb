def word_end_cs
  puts "Введите слово: "
  word = gets.chomp.to_s

  if word.upcase.end_with?("CS")
    puts 2**word.length
  else
    puts word.reverse
  end
end

word_end_cs