require 'minitest/autorun'
require 'minitest/pride'
require './lib/board'
require './lib/cell'
require './lib/ship'
require './lib/board_setup'
require './lib/game_message'
require 'pry'

class BoardSetupTest < MiniTest::Test
  def test_it_exists
    board_setup = BoardSetup.new

    assert_instance_of BoardSetup, board_setup
  end

  def test_it_has_readable_attributes
    board_setup = BoardSetup.new

    assert_equal Board.new.render, board_setup.board.render
  end

  def test_if_computer_can_place_ship
    board_setup = BoardSetup.new
    cruiser = Ship.new("Cruiser", 3)
    board_setup.computer_place_ship(cruiser)

    test = board_setup.board.cells.values.select do |cell|
      cell.render(true) == "S"
    end

    assert_equal 3, test.count
  end

  def test_if_computer_can_place_multiple_ships
    board_setup = BoardSetup.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    board_setup.computer_place_ship(cruiser)
    board_setup.computer_place_ship(submarine)

    test = board_setup.board.cells.values.select do |cell|
      cell.render(true) == "S"
    end

    assert_equal 5, test.count
    # assert_equal "TEST BOARD", board_setup.board.render(true) #Uncomment this line to see ship placement.
  end

  def test_if_computer_can_select_cells
    board_setup = BoardSetup.new
    random_cruiser = ["C2", "D4", "A1"]
    random_sub = ["B2", "B3"]
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    assert_equal random_cruiser.length, board_setup.computer_select_cells(cruiser.health).length
    assert_equal random_sub.length, board_setup.computer_select_cells(submarine.length).length
  end

  def test_if_player_can_place_ship_valid
    board_setup = BoardSetup.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    board_setup.player_place_ship(cruiser, ["A1", "A2", "A3"])

    test = board_setup.board.cells.values.select do |cell|
      cell.render(true) == "S"
    end

    assert_equal 3, test.count
    # assert_equal "TEST BOARD", board_setup.board.render(true) #Uncomment this line to see ship placement.
  end

end
