def pokemon_number
  puts "Сколько покемонов вы хотите добавить?"
  gets.chomp.to_i
end

def get_pokemon(index)
  puts "Введите имя вашего покемона #{index + 1}"
  name_pok = gets.chomp.to_s
  puts "Введите цвет вашего покемона #{index + 1}"
  color_pok = gets.chomp.to_s
  { name: name_pok, color: color_pok }
end

def create_array_of_pokemon
  num_pok = pokemon_number
  pokemon_array = []

  num_pok.times do |index|
    get_pok = get_pokemon(index)
    pokemon_array << get_pok
  end

  pokemon_array
end

def output_list_pokemon(pokemon_array)
  pokemon_array.each_with_index do |pokemon|
    puts pokemon
  end
end

pokemon_array = create_array_of_pokemon
output_list_pokemon(pokemon_array)