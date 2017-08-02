time_tables = [
  {"route" => "New York -> Boston", "schedule" => 
    {"New York" => "12:02", "New Haven" => "13:50", "Providence" => "15:13", "Boston" => "16:36"}
  },
  {"route" => "New York -> Chicago", "schedule" =>
    {"New York" => "8:19", "Albany" => "11:40", "Buffalo" => "17:21", "Cleveland" => "21:12", "Toledo" => "23:18", "Chicago" => "5:28"}
  }
]

puts "Please select a train #"
time_tables.each_with_index do |train, index|
  puts "#{index+1}: #{train["route"]}"
end

user_input = gets.to_i
puts time_tables[user_input - 1]["route"]
time_tables[user_input - 1]["schedule"].each do |city, time|
  puts "#{city}: #{time}"
end
