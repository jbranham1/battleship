require './lib/board'
require './lib/ship'

class BoardSetup
  attr_reader :board
  #this class should house setting up the board. Meaning placing boats.
  #Iteration 4 = adding board dimensions

  def initialize
    @board = Board.new
  end

  def computer_select_cells(length)
    randomized_cells = @board.cells.keys.shuffle
    spaces = randomized_cells.shift(length)
  end

  def computer_place_ship(ship)
    loop do
      coordinates = computer_select_cells(ship.length)
      if !@board.place(ship, coordinates).nil?
        break
      end
    end
  end

  def player_place_ship(ship, coordinates)
      @board.place(ship, coordinates)
  end
end
