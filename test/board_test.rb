require 'minitest/autorun'
require 'minitest/pride'
require './lib/board'
require './lib/cell'
require './lib/ship'
require 'pry'

class BoardTest < MiniTest::Test
  def test_it_exists
    board = Board.new

    assert_instance_of Board, board
  end

  def test_it_has_readable_attributes
    board = Board.new

    assert_equal 16, board.cells.count
    assert_equal Hash, board.cells.class
    assert_equal Cell, board.cells.values[1].class
  end

  def test_valid_coordinate?
    board = Board.new

    assert_equal true, board.valid_coordinate?("A1")
    assert_equal false, board.valid_coordinate?("E1")
  end

  def test_valid_placement_for_length
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)

    assert_equal false, board.valid_placement?(cruiser, ["A1", "A2"])
    assert_equal true, board.valid_placement?(cruiser, ["A1", "A2", "A3"])
  end

  def test_valid_placement_horizontal
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)

    assert_equal false, board.valid_placement?(cruiser, ["A1", "A2", "A4"])
    assert_equal false, board.valid_placement?(cruiser, ["A1", "A2", "B3"])
    assert_equal true, board.valid_placement?(cruiser, ["A1", "A2", "A3"])
  end

  def test_valid_placement_vertical
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)

    assert_equal false, board.valid_placement?(cruiser, ["A1", "B2", "C4"])
    assert_equal false, board.valid_placement?(cruiser, ["A1", "B1", "D1"])
    assert_equal true, board.valid_placement?(cruiser, ["A1", "B1", "C1"])
  end

  def test_consecutive_horizontal
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    assert_equal false, board.consecutive?(["A1", "A2", "A4"])
    assert_equal false, board.consecutive?(["A1", "A2", "B3"])
    assert_equal true, board.consecutive?(["A1", "A2", "A3"])
  end

  def test_consecutive_vertical
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)

    assert_equal false, board.consecutive?(["A1", "B2", "C4"])
    assert_equal false, board.consecutive?(["A1", "B1", "D1"])
    assert_equal true, board.consecutive?(["A1", "B1", "C1"])
  end

  def test_set_letters
    board = Board.new
    letters = ["A"]
    assert_equal letters, board.set_letters(["A1", "A2", "A3"])

    letters = ["A", "B", "C"]
    assert_equal letters, board.set_letters(["A1", "B2", "C3"])
  end

  def test_set_numbers
    board = Board.new
    numbers = ["1","2","3"]
    assert_equal numbers, board.set_numbers(["A1", "A2", "A3"])

    numbers = ["1"]
    assert_equal numbers, board.set_numbers(["A1", "B1", "C1"])
  end

  def test_place_ship
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)

    board.place(cruiser, ["A1", "A2", "A3"])
    cell_1 = board.cells["A1"]
    cell_2 = board.cells["A2"]
    cell_3 = board.cells["A3"]

    assert_equal cruiser, cell_1.ship
    assert_equal cruiser, cell_2.ship
    assert_equal cruiser, cell_3.ship
  end

  def test_place_overlapping_ships
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    assert_equal true, board.valid_placement?(cruiser, ["A1", "A2", "A3"])
    board.place(cruiser, ["A1", "A2", "A3"])
    cell_1 = board.cells["A1"]
    cell_2 = board.cells["A2"]
    cell_3 = board.cells["A3"]

    assert_equal false, board.valid_placement?(submarine, ["A1", "A2"])
  end
end
