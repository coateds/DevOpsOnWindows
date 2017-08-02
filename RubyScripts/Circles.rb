def area radius
	Math::PI * radius ** 2
end

def circumference radius
	2 * Math::PI * radius
end


puts "Input Radius"
user_input = gets.to_f

if user_input >= 0
	puts "Area = #{area user_input}"
	puts "Circ = #{circumference user_input}"
else
	puts "Bad Input"
end
