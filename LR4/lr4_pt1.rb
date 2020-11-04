=begin
Переписать банкомат из ЛЗ #3 на работу с классами
Класс должен называться - CashMachine.
Программа должна запускаться с помощью метода класса init, создавать экземпляр класса
и взаимодействовать с пользователем согласно условиям задачи
=end
require 'io/console'

DefBalance = 100.0

class CashMachine

  def self.init
    CashMachine.new.choose_option
  end

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
      choose_option
    else
      balance = DefBalance
      puts "Your current balance: #{balance}"
      choose_option
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
    choose_option
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
    choose_option
  end

  def choose_option
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
      choose_option
    end
  end
end
CashMachine.init