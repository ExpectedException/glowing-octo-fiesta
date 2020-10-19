=begin
Написать скрипт, который принимает пару чисел, если хотя бы одно равно 20 - возвращает его, в противном случае выводит сумму этих чисел.
=end
def numInput
	temp = 0
    puts 'Введите два числа через пробел'
	num = gets.chomp
    num = num.chomp.split(' ',-1)
    if num.length == 2 and num.all? {|i| i.match?(/\d/) }
		num = num.map(&:to_f)
        num.each {|item|
			temp += item
            if item == 20
                return puts "NUMBER: #{item}"
            end }
		puts "Your number is: #{temp}"
    else
        numInput
    end
end
numInput