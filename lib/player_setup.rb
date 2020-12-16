require "./lib/game_message"
require "./lib/ship"

class PlayerSetup
  attr_reader :ships
  def initialize
    @ships = []
    @game_message = GameMessage.new
    @board_cells_count = 0
  end

  def get_ships(board_length)
    @game_message.player_ships
    loop do
      @ships << Ship.new(get_name, get_length(board_length))
      puts "Ship added. Would you like to add another? Yes/No"
      if !add_another?
        break
      else
        if @board_cells_count == (board_length * board_length) ||
          @ships.count == 4
          puts "Cannot enter any more ships."
          break
        end
      end
    end
    puts "Let's play!"
    puts "==============================="
  end

  def add_another?
    loop do
      answer = gets.chomp.downcase
      @add_another = false
      if answer != "no" && answer != "yes"
        puts "Must enter valid answer. Yes/No"
      elsif answer == "no"
        @add_another = false
        break
      elsif answer == "yes"
        @add_another = true
        break
      end
    end
    @add_another
  end

  def get_name
    @game_message.get_ship_name
    name = gets.chomp
  end

  def get_length(board_length)
    loop do
      @game_message.get_ship_length
      @length = gets.chomp.to_i
      if @length < 1 || @length > board_length
        puts "Length must be a number between 1 and #{board_length}"
      else
        @board_cells_count += @length
        break
      end
    end
    @length
  end
end
