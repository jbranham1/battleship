require 'minitest/autorun'
require 'minitest/pride'
require './lib/board'
require './lib/cell'
require './lib/ship'
require './lib/board_setup'
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
      cell.render == "S"
    end

    assert_equal 3, test
  end

  def test_if_computer_can_select_cells
    skip
    board_setup = BoardSetup.new
    random_cells = ["C2", "D4", "A1"]

    assert_equal random_cells.length, board_setup.computer_select_cells.length
  end

  def test_if_computer_can_select_cell2
    skip
    board_setup = BoardSetup.new
    test = board_setup.computer_select_space1

    assert_equal test, board_setup.computer_select_space2
  end
end
