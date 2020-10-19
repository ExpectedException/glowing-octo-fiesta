=begin
 Написать скрипт, который будет выводить массив покемонов
- Спросит сколько добавить покемонов
- Указанное на предыдущем этапе число раз спросит имя и цвет каждого покемона
- Выведет в консоль массив содержащий хеши покемонов в формате [{ name: 'Pikachu', color: 'Yellow' }]
=end
def inputNumberOfP
    puts "Сколько добавить покемонов?"
    numP = gets.chomp.to_i
    return numP
end
def inputTypeOfP
    numP = inputNumberOfP
    $i = 0
    pHash = {}
    while $i < numP  do
        puts "Enter name of P: "
        name = gets.chomp
        puts "Enter color of P: "
        color = gets.chomp
        pHash[name] = color
        $i += 1
    end
    return pHash
end
def main
    pHash = inputTypeOfP
    puts pHash
end
main
