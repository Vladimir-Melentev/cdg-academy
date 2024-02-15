class CashMachine
  BALANCE = File.dirname(__FILE__) + "/Files_txt/balance.txt".freeze
  STARTING_BALANCE = 100
    def initialize
      read_balance
    end

    def deposit(amount)
      current_balance = read_balance
      new_balance = current_balance + amount
      write_balance(new_balance)
      new_balance
    end

    def withdraw(amount)
      current_balance = read_balance
      if current_balance >= amount
        new_balance = current_balance - amount
        write_balance(new_balance)
        new_balance
      else
        "Insufficient funds"
      end
    end

    def balance
      read_balance
    end

    private

   def read_balance
      if File.exist?(BALANCE)
        File.read(BALANCE).to_i
      else
        write_balance(STARTING_BALANCE)
        STARTING_BALANCE
      end
    end

    def write_balance(new_balance)
      File.write(BALANCE, new_balance.to_s)
    end
  end
