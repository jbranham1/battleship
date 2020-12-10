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
    randomized_cells.shift(3)
  end

  def computer_select_cells_submarine
    randomized_cells = @board.cells.keys.shuffle
    randomized_cells.shift(2)
  end

  def computer_place_ship_cruiser
    cruiser = Ship.new("Cruiser", 3)
    @board.valid_placement?(cruiser, computer_select_cells_cruiser)
  end

  def player_place_ships
    #p game_message.game_explanation
  end
end
