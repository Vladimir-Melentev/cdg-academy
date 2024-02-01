def greeting
  puts "Введите ваше имя: "
  name = gets.chomp.to_s
  puts "Введите вашу фамилию: "
  second_name = gets.chomp.to_s
  puts "Введите ваш возраст: "
  age = gets.chomp.to_i

  if age >= 18
    puts "Привет, #{name} #{second_name}. Самое время занятя делом!"
  else
    puts "Привет, #{name} #{second_name}. Тебе меньше 18 лет, но начать учится программировать никогда не рано."
  end
end

greeting