$user_balance = 0
$balance_in_file = false

#установка баланса в глобальную перменную
def set_user_balance
    #если существует файл с балансом - установить значение из него
    if File.exist?("balance.txt") then
        $user_balance = File.read("balance.txt").to_i
        $balance_in_file = true
        #иначе установить в 100
    else
        $user_balance = 100
        $balance_in_file = false
    end
end

#перезапись баланса в файл
def rewrite_user_balance_file
    #если данные об балансе были прочитаны из файла
    if $balance_in_file then
        #если файл существует - перезаписывает
        if File.exist?("balance.txt") then
            File.write("balance.txt", $user_balance, mode: "w")
            #если файл удалили/переименовали/перенесли
        else
            puts "Ошибка записи - файл баланса не найден"
        end
    end
    #иначе нам ничего делать не надо
end

#вывод текста меню
def get_choise_menu
    puts "Выберите действие"
    puts "D - положить"
    puts "W - снять"
    puts "B - проверить баланс"
    puts "Q - выйти\n"
end

#положить на счет
def deposit(num)
    $user_balance += num
    return balance
end

#снять со счета
def withdraw(num)
    temp = num
    #проверка на достаточность денег на счету
    if $user_balance - temp >= 0 then
        $user_balance -= temp
    else
        return "Недостаточно средств\n#{balance}"
    end
    return balance
end

#вывод баланса
def balance
    return "Ваш баланс равен #{$user_balance}\n"
end

#текст выхода из приложения для меню
def quit
    return "Спасибо что пользовались нашим приложением\n"
end



#web интерфейс
def wi
    require 'socket'
    server = TCPServer.open(2000)
    while true
        res = "HTTP/1.1 200 OK"
        client = server.accept
        response = client.gets
        method, uri = response.split(" ")
        if method == "GET" then
            uri, num = uri.split("?value=")
            if uri == "/balance" then
                res = "#{res}\n\n#{balance}"
            elsif uri == "/withdraw" then
                res = "#{res}\n\n#{withdraw(num.to_i)}"
            elsif uri == "/deposit" then
                res = "#{res}\n\n#{deposit(num.to_i)}"
            elsif uri == "/quit" then
                res = "#{res}\n\n#{quit}"
                client.print res
                client.close()
                break
            else
                res = "HTTP/1.1 404\n\nкоманда не найдена"
            end
        end
        client.print res
        client.close()
    end
end

#собственно программа
set_user_balance
wi
rewrite_user_balance_file
