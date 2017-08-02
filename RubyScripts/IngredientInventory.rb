class Ingredient
    attr_accessor :type, :stock, :daily

    def amount_needed
        @daily * 7 -@stock
    end
end

inventory = []

def add_new_ingredient inventory
	new_ingredient = Ingredient.new
	puts "Type of ingredient"
	new_ingredient.type = gets.strip
	puts "Current Stock"
	new_ingredient.stock = gets.to_i
	puts "Daily Amount Required"
	new_ingredient.daily = gets.to_i
	inventory[inventory.size] = new_ingredient
end

def shopping_list inventory
	inventory.each do |ingredient|
		puts "#{ingredient.type} \t\t\t #{ingredient.amount_needed}"
	end
end

def info
	puts "'1' to add an ingredient. '2' to print out shopping list '3' to exit"
end

info
while user_input = gets.strip

	case user_input
		when "1"
			add_new_ingredient inventory
		when "2"
			shopping_list inventory
		when "3"
			break
	end
	info
end
