require "./lib/game"

puts "Welcome to BATTLESHIP"

loop do
  puts "---------------------------------"
  puts "Enter p to play. Enter q to quit."
  answer = gets.chomp.upcase
  if answer == "P"
    game = Game.new
    game.game_start
  elsif answer == "Q"
    break
  else
    puts "Invalid input."
  end
end
