require './lib/board'
require './lib/ship'
require './lib/game_message'

class BoardSetup
  attr_reader :board,
              :computer_cruiser,
              :computer_sub,
              :player_cruiser,
              :player_sub,
              :game_messages
  #this class should house setting up the board. Meaning placing boats.
  #Iteration 4 = adding board dimensions

  def initialize
    @board = Board.new
    @computer_cruiser = Ship.new("Cruiser", 3)
    @computer_sub = Ship.new("Submarine", 2)
    @player_cruiser = Ship.new("Cruiser", 3)
    @player_sub = Ship.new("Submarine", 2)
    @game_messages = GameMessage.new

  end

  def computer_select_cells(length)
    randomized_cells = @board.cells.keys.shuffle
    spaces = randomized_cells.shift(length)
  end

  def computer_select_cells_submarine
    randomized_cells = @board.cells.keys.shuffle
    randomized_cells.shift(2)
  end


  def computer_place_ship(ship)
    loop do
      coordinates = computer_select_cells(ship.length)
      if !@board.place(ship, coordinates).nil?
        break
      end
    end
  end

  def player_valid_entry
    game_messages.computer_board_placement(@board.board)
    loop do
      player_coordinates = gets.chomp.upcase.split
      if !player_place_ship(ship, player_coordinates).nil?
        break
      else
        game_messages.invalid_input_for_coordinates
      end
    end
  end

  def player_place_ship(ship, coordinates)
      @board.place(ship, coordinates)
  end
end
