require "./lib/game_message"
require "./lib/ship"

class PlayerShips
  attr_reader :ships
  def initialize
    @ships = []
  end

  def get_ships(board_length)
    puts "Please enter your ships:"
    loop do
      @ships << Ship.new(get_name, get_length)
      puts "Ship added. Would you like to add another? Yes/No"
      if !add_another?
        break
    end
  end
  def add_another?
    answer = gets.chomp.downcase
    loop do
      if answer != "no" && answer != "yes"
        puts "Must enter valid answer. Yes/No"
      elsif answer == "no"
        return false
        break
      elsif answer == "yes"
        return true
        break
      end
    end
  end

  def get_name
    @game_message.get_ship_name
    name = gets.chomp
  end

  def get_length(board_length)
    loop do
      @game.message.get_ship_length
      length = gets.chomp
      if length.to_i != length || length > board_length
        puts "Length must be a number between 1 and #{board_length}"
      else
        return length
        break
      end
    end
  end
end
