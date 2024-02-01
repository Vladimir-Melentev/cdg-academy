def foobar
  puts "Вам нужно ввести пару чисел и вы узнаете их сумму. Но если одно из них будет 20, оно не будет принято"
  puts "Введите первое число: "
  first_number = gets.chomp.to_i
  puts "Введите второе число: "
  second_number = gets.chomp.to_i

  if first_number == 20
    puts second_number
  elsif second_number == 20
    puts first_number
  else
    puts first_number + second_number
  end
end

foobar