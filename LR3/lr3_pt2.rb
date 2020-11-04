=begin
Напишите программу, которрая начинается с чтения банковского баланса клиента
из файла с именем balance.txt. Этот файл содержит одну строку со стартовым балансом клиента.
Если файл не существует, используйте стартовый баланс 100.0, который должен быть константой.

После этого программа повторно предложит клиенту внести деньги, вывести деньги,
вывести деньги, проверить баланс или выйти, используя буквы D(deposit),W(withdraw),
B(balance) и Q (quit), программа должна принимать на вход значения в верхнем или нижнем регистре.

Для депозитов (D), программа подсказывает сумму. Сумма должна быть больше нуля.
Если сумма действительна, программа добавляет сумму депозита к балансу клиенту и отображает новый баланс.
При снятии средств программа выдаст запрос на сумму. Сумма должна быть больше нуля и меньше или равна текущему балансу.
Если сумма корректна, то программа вычитает сумму вывода из баланса клиента и отображает новый баланс.

При снятии средств (W) программа выдаст запрос на сумму. Сумма должна быть больше нуля и меньше, или равна текущему балансу.
Если сумма корректна, то программа вычитает сумму вывода из баланса клиента и отображает новый баланс.

Для проверки баланса (B) программа просто выводит текущий баланс.

Когда клиент решит выйти из программы (Q), программа запишет текущий баланс обратно в файл balance.txt

В случае неправильного ввода (команда или сумма), ваша программа должна выдать соответствующее сообщение об ошибке,
которое говорит клиенту, как её исправить. Нельзя выводить "Error!" - это не поможет.
=end
require 'io/console'

DefBalance = 100.0

def readBalance
  if File.exist?('balance.txt')
    balance = File.read('balance.txt').chomp
    puts "Your current balance: #{balance}"
    return balance
  else
    balance = DefBalance
    return balance
  end
end

def balance
  if File.exist?('balance.txt')
    balance = File.read('balance.txt').chomp
    puts "Your current balance: #{balance}"
    chose_option
  else
    balance = DefBalance
    puts "Your current balance: #{balance}"
    chose_option
  end
end

def deposit
  balance = readBalance.to_f
  puts 'Enter amount to be deposited...'
  input = gets.chomp
  case input
  when /\d*\.?\d/
    balance += input.to_f
    File.write('balance.txt', balance.to_s)
  else
    puts 'Input must be a positive number'
    deposit
  end
  chose_option
end

def withdraw
  balance = readBalance.to_f
  puts 'Enter amount to be withdrawn...'
  input = gets.chomp
  case input
  when /\d*\.?\d/
    balance -= input.to_f
    File.write('balance.txt', balance.to_s)
  else
    puts 'Input must be a positive number'
    withdraw
  end
  chose_option
end
# wtd lambda
def chose_option
  puts 'D(deposit), W(withdraw), B(balance), Q (quit)'
  key = STDIN.getch.upcase!.chomp.to_s
  puts key
  case key
  when 'D'
    deposit
  when 'W'
    withdraw
  when 'B'
    balance
  when 'Q'
    puts 'Exiting...'
    exit
  else
    chose_option
  end
end
chose_option