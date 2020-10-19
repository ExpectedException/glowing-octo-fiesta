=begin
У вас есть файл, со следующей структурой и содержащий не менее 10 строк: Имя, фамилия
и возраст
Прим.
Иван Иванов 20
Петр Петров 21
Необходимо прочитать файл, затем запросив у пользователя ввод возраста, найти в
результатах чтения файла, студента чей возраст равен введенному числу и записать этого
студента(тов) в другой файл с названием results.txt. После этого перезапросить ввод.
Программа завершается выводом на экран содержимого файла results.txt построчно, если
все студенты из первого файла были записаны во второй или если пользователь ввел с
клавиатуры -1
=end
def openReadDelete(age)
    File.foreach("input.txt") { |line| checkForConformity(age, line) }
    ageInput
    File.close
end

def delete(line)
    text = File.read("input.txt")
    replace = text.gsub(line, "")
    File.open('input.txt', "w") {|file| file.puts replace}
end
#wtd replace line by line "??"
def checkForConformity(age, line)
    if line.include?(age.to_s)
        delete(line)
        File.write("results.txt","#{line.chomp}\n", mode: "a")
    end
end

def ageInput()
    puts "Enter age or -1 to exit"
    age = gets.chomp.to_s
    if age.include?("-1") == true
        exit
    else
        openReadDelete(age)
    end
end
ageInput