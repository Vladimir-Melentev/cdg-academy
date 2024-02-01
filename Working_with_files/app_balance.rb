BALANCE = "./Files_txt/balance.txt".freeze
STARTING_BALANCE = 100

def read_balance
  if File.exist?(BALANCE)
    File.read(BALANCE).to_i
  else
    File.write(BALANCE, STARTING_BALANCE.to_s)
    STARTING_BALANCE
  end
end

def deposit(amount)
  current_balance = read_balance
  new_balance = current_balance + amount
  File.write(BALANCE, new_balance.to_s)
  puts "Your balance: #{new_balance}"
end

def withdraw(amount)
  current_balance = read_balance
  if current_balance >= amount
    new_balance = current_balance - amount
    File.write(BALANCE, new_balance.to_s)
    puts "Your balance: #{new_balance}"
  else
    puts "Insufficient funds"
  end
end

def display_balance
  balance = read_balance
  puts "Your balance: #{balance}"
end

def bank_application
  loop do
    puts "\nWhat operation to use?"
    puts "D - Deposit"
    puts "W - Withdraw"
    puts "B - Balance"
    puts "Q - Quit"

    choice = gets.chomp.upcase

    case choice
    when "D"
      puts "Enter the deposit amount:"
      deposit_amount = gets.chomp.to_i
        if deposit_amount >= 0
        deposit(deposit_amount)
        else
          puts "Amount must be greater than 0"
        end
    when "W"
      puts "Enter the withdrawal amount:"
      withdrawal_amount = gets.chomp.to_i
      if withdrawal_amount >= 0
      withdraw(withdrawal_amount)
      elsif withdrawal_amount < 0
        puts "Amount must be greater than 0"
      else
        puts "Insufficient funds"
      end
    when "B"
      display_balance
    when "Q"
      puts "Goodbye! 'exit the program'"
      display_balance
      break
    else
      puts "Invalid choise. Please choose again"
    end
  end
end

bank_application