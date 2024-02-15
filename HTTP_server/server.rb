require 'socket'
require './Cash_machine/cash_machine'

class Server
  def initialize
    @cash_machine = CashMachine.new
    @server = TCPServer.new('0.0.0.0',3000)
    # Запускаем сервер для обработки запросов
    run_server
  end

  def run_server
    loop do
      # Принимаем подключение от клиента
      client = @server.accept
      # Читаем запрос от клиента
      request = client.gets

      if request
        # Обрабатываем запрос и отправляем ответ
        handle_request(request, client)
      else
        # Закрываем соединение, если запрос не получен
        client.close
      end
    end
  end

  private

  # Обработка запроса от клиента
  def handle_request(request, client)
    # Разбираем строку запроса на метод и путь
    method, path_and_params = request.split(' ')
    path, params_str = path_and_params.split('?')

    case path
    when '/'
      # Возвращаем текущий баланс при запросе корня
      client.puts "HTTP/1.1 200 OK\r\n\r\n#{@cash_machine.balance}"
    when '/deposit'
      # Обработка запроса на увеличение депосита
      amount = parse_params(params_str)['value'].to_i
      if amount >= 0
        new_balance = @cash_machine.deposit(amount)
        client.puts "HTTP/1.1 200 OK\r\n\r\nDeposit successful. Your balance: #{new_balance}"
      else
        client.puts "HTTP/1.1 400 Bad Request\r\n\r\nAmount must be greater than 0"
      end
    when '/withdraw'
      # Обработка запроса на снятие
      amount = parse_params(params_str)['value'].to_i
      if amount >= 0
        result = @cash_machine.withdraw(amount)
        if result.is_a?(Integer)
          client.puts "HTTP/1.1 200 OK\r\n\r\nWithdrawal successful. Your balance: #{result}"
        else
          client.puts "HTTP/1.1 400 Bad Request\r\n\r\n#{result}"
        end
      else
        client.puts "HTTP/1.1 400 Bad Request\r\n\r\nAmount must be greater than 0"
      end
    else
      # Обработка неизвестного пути
      client.puts "HTTP/1.1 404 Not Found\r\n\r\nInvalid path"
    end

    # Закрываем соединение
    client.close
  end

  # Парсинг строки параметров запроса
  def parse_params(params_str)
    return {} unless params_str

    params = {}
    params_str.split('&').each do |param|
      key, value = param.split('=')
      params[key] = value
    end

    params
  end
end

# Создаем экземпляр класса Server и запускаем сервер
Server.new.run_server