=begin
Написать скрипт, который будет запрашивать имя, фамилию и возраст, а затем выдавать приветствие в одном из двухвариантов, в зависимости от возраста:
 	- Привет, {имя} {фамилия}. Тебе меньше 18 лет, но начать учиться программировать никогда не рано
	- Привет, {имя} {фамилия}. Самое время заняться делом!
=end
if __FILE__ == $0
    puts ' Введите фамилию, имя и возраст'
	name = gets
    $final = []
	puts name.inspect
    $first_name, $last_name, $age = nil
	age = nil

	def splitter(name)
		if !name.empty?
			$final = name.split(' ', -1)
			puts $final
			$first_name, $last_name, $age = $final
			$age = $age.to_i
			else
				puts 'EMPTY'
				nil
		end
	end

    def PrintResult()
		if $age < 18
			puts "Привет, #{$last_name} #{$first_name}. Тебе меньше 18 лет, но начать учиться программировать никогда не рано"
		elsif $age >18
			puts "Привет, #{$last_name} #{$first_name}. Самое время заняться делом!"
		else
			puts '?'
		end
	end
    splitter(name)
    PrintResult()
end