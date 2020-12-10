require './lib/board'

class BoardSetup
  attr_reader :board
  #this class should house setting up the board. Meaning placing boats.
  #Iteration 4 = adding board dimensions

  def initialize (user_board = false)
    @board = Board.new
  end

  def computer_select_cell
    placement_1 = @board.cells.keys.sample
  end
  def computer_place_ship_cruiser
    cruiser = Ship.new("Cruiser", 3)
    @board.place(cruiser, ["A1", "A2", "A3"])


    cruiser.health.times {computer_select_cell}

    # computer_select_cell

  end

  def player_place_ships
    #p game_message.game_explanation
  end

end
