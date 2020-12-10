require "./lib/game_message"
puts "Welcome to BATTLESHIP"

message = GameMessage.new
loop do
  puts "Enter p to play. Enter q to quit."
  answer = gets.chomp.upcase
  if answer == "P"
    #play game
  elsif answer == "Q"
    break
  else
    puts "Invalid input."
  end
end
