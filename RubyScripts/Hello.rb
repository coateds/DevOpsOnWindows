class Spaceship
#attr_accessor :destination #RW
#attr_reader :name #RO
#attr_writer :name #WO

  def initialize(name, cargo_module_count)
    @name = name
    #@cargo_hold = CargoHold.new(cargo_module_count)
    @cargo_hold = cargo_module_count
    @power_level = 100
  end
  
#  def launch(destination)
#    @destination = destination  #This is private to the class
#    # go towards destination
#  end
#  def destination
#    @destination
#  end
end

ship = Spaceship.new("Dreadnought", 4)
p ship

#Ent = Spaceship.new
#Ent.launch("Neptune")
#Ent.destination = "Neptune"
# puts Ent.inspect
#puts Ent.destination

# puts "Hello Goober"
# res = `time /t`
# puts res
# res = `powershell get-date`
# puts res

# puts "Input an integer"
# user_input = gets.to_i
# 
# if user_input > 10
#     output = user_input * user_input
# else
#     output = user_input *2
# end
# 
# puts output

# first_five_integers = [1,2,3,4,5]
# first_five_integers.each do |my_integer|
#     puts my_integer
# end

######################
# grocery_items = {"oranges" => false, "bananas" => false}
# puts "Do you need:"
# 
# grocery_items.each do | item, need_for_item |
#     puts item + "? (Y/N)"
#     # case gets
#     #     when "Y\n"
#     #         grocery_items[item] = true
#     #     when "N\n"
#     #         grocery_items[item] = false
#     # end
# 
#     case gets.strip
#         when "Y"
#             grocery_items[item] = true
#         when "N"
#             grocery_items[item] = false
#     end
# end
# 
# puts "Here's your list:"
# grocery_items.each do | item, need_for_item |
#     puts item if need_for_item
# end
######################

######################
# bank_account = 50
# bank_account2 = 100
# puts "You have #{bank_account} dollars in one account and #{bank_account + bank_account2} dollars total"
# 
# puts "cat".upcase
# puts "DOG".downcase
# 
# my_sentence = "the quick brown goober just sat there"
# array = my_sentence.split(" ")
# puts array[3]
# puts "the sentence has #{array.count} words"
# 
# # use the bang to sort the current array, no bang to create a new sorted array
# puts array.sort!
######################

######################
# integers = []  # create empty array
# current_integer = 0
# while current_integer < 10 do
#     puts "Type an integer"
#     integers[current_integer] = gets.to_i
#     current_integer += 1
# end
# 
# integers.sort.each do |this_int|
#     puts this_int
# end
######################

######################
# array_range = 2..8
# array_range.each do |element|
#     puts "Element = #{element}"
# end
######################

######################
# Loop Controls Next, Redo and Break
# puts "Type something to continue. Or nothing to quit"
# while a = gets do
# 
#     if a == "\n"
#         Break
#     end
#     puts a
# end

# total = 0
# puts "Input your numbers"
# while input = gets do
#     if input == "\n"
#         break
#     end
#     # .to_f floating
#     total = total + input.to_f
#     puts "running total = #{total}"
# end
#
# puts "Total: #{total}"
######################

# Methods
######################
# def get_ingredient 
#     new_ingredient = gets 
#     if new_ingredient != "\n"
#         new_ingredient 
#     else
#         false 
#     end 
# end 
# 
# ingredients = []
# puts "Input your ingredients" 
# 
# while my_ingredient = get_ingredient do 
#     ingredients[ingredients.count] = my_ingredient 
# end 
# 
# puts "Input your instructions" 
# instructions = gets
# puts "Ingredients:"
# puts ingredients
# puts "Instructions:"
# puts instructions

# def multiply_this a, b
#     total = a * b
#     if total < 0
#         false
#     else
#         total
#     end
# end
# 
# user_input = []
# puts "Input two numbers"
# 
# while user_number = gets do
#     user_input[user_input.count] = user_number.to_f
#     if user_input.count == 2
#         break
#     end
# end
# 
# if result = multiply_this(user_input[0], user_input[1])
#     puts result
# else
#     puts "Invalid Entry"
# end
######################

