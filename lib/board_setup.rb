require './lib/board'
require './lib/ship'

class BoardSetup
  attr_reader :board
  #this class should house setting up the board. Meaning placing boats.
  #Iteration 4 = adding board dimensions

  def initialize
    @board = Board.new
  end

  def computer_select_cells_cruiser
    randomized_cells = @board.cells.keys.shuffle
    spaces = randomized_cells.shift(3)
  end

  def computer_select_cells_submarine
    randomized_cells = @board.cells.keys.shuffle
    randomized_cells.shift(2)
  end


  def computer_place_ship(ship)
    loop do
      coordinates = computer_select_cells_cruiser
      if !@board.place(ship, coordinates).nil?
        break
      end
      coordinates
    end
  end

  def create_computer_ships
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
  end
  #
  # def computer_select_space1
  #   randomized_cells = @board.cells.keys.shuffle
  #   space1 = randomized_cells.shift
  #   space1.split
  # end
  #
  # def computer_select_space2
  #   ship_placement =[]
  #     @board.cells.keys[0].each do |cell|
  #     if computer_select_space1[0][0] == @board.cells.keys[0][0]
  #       ship_placement << @board.cells.keys
  #     else
  #     end
  #   end
  # end

  def player_place_ships
    #p game_message.game_explanation
  end
end
