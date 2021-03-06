require 'minitest/autorun'
require 'minitest/pride'
require './lib/board'
require './lib/ship'
require './lib/board_setup'
require './lib/game_message'
require './lib/board'

class BoardSetupTest < MiniTest::Test
  def test_it_exists
    board_setup = BoardSetup.new

    assert_instance_of BoardSetup, board_setup
  end

  def test_if_computer_can_place_ship
    board_setup = BoardSetup.new
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    board_setup.computer_place_ship(board, cruiser)

    test = board.cells.values.select do |cell|
      cell.render(true) == "S"
    end

    assert_equal 3, test.count
  end

  def test_if_computer_can_place_multiple_ships
    board_setup = BoardSetup.new
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    board_setup.computer_place_ship(board, cruiser)
    board_setup.computer_place_ship(board, submarine)

    test = board.cells.values.select do |cell|
      cell.render(true) == "S"
    end

    assert_equal 5, test.count
  end

  def test_if_computer_can_select_cells
    board_setup = BoardSetup.new
    board = Board.new
    random_cruiser = ["C2", "D4", "A1"]
    random_sub = ["B2", "B3"]
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    cruiser_cells = board_setup.computer_select_cells(board, cruiser.length)
    submarine_cells = board_setup.computer_select_cells(board, submarine.length)

    assert_equal random_cruiser.length, cruiser_cells.length
    assert_equal random_sub.length, submarine_cells.length
  end
end
