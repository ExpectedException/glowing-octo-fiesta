=begin
Написать скрипт, который будет принимать число и слово, если слово заканчивается на “CS”
- выводит на экран цифру 2 в степени (длины введенного слова),
если не заканчивается - выводит слово задом наперед
=end
def main
    puts "Type a number"
    num = gets.chomp
    puts "Type a word"
    word = gets.chomp
    if word.match?(/CS/)
        puts 2**word.length
    else
        puts word.reverse
    end
end
main
