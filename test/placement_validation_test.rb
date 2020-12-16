require 'minitest/autorun'
require 'minitest/pride'
require './lib/board'
require './lib/ship'
require './lib/placement_validation'

class PlacementValidationTest < MiniTest::Test
  def test_it_exists
    validation = PlacementValidation.new

    assert_instance_of PlacementValidation, validation
  end

  def test_consecutive_horizontal
    board = Board.new(10)
    cruiser = Ship.new("Cruiser", 3)
    validation = PlacementValidation.new

    assert_equal false, validation.consecutive?(["A1", "A2", "A4"])
    assert_equal false, validation.consecutive?(["A1", "A2", "B3"])
    assert_equal true, validation.consecutive?(["A1", "A2", "A3"])
  end

  def test_consecutive_vertical
    board = Board.new(10)
    cruiser = Ship.new("Cruiser", 3)
    validation = PlacementValidation.new

    assert_equal false, validation.consecutive?(["A1", "B2", "C4"])
    assert_equal false, validation.consecutive?(["A1", "B1", "D1"])
    assert_equal true, validation.consecutive?(["A1", "B1", "C1"])
  end

  def test_letters
    validation = PlacementValidation.new
    board = Board.new(10)
    letters = ["A"]
    assert_equal letters, validation.letters(["A1", "A2", "A3"])

    letters = ["A", "B", "C"]
    assert_equal letters, validation.letters(["C1", "B2", "A3"])
  end

  def test_letters_sort
    validation = PlacementValidation.new
    board = Board.new(10)
    coordinates = ["B10", "C10", "A10"]

    assert_equal ["A", "B", "C"], validation.letters_sort(coordinates)
  end

  def test_numbers
    validation = PlacementValidation.new
    board = Board.new(10)
    numbers = ["1","2","3"]
    assert_equal numbers, validation.numbers(["A1", "A2", "A3"])

    numbers = ["1"]
    assert_equal numbers, validation.numbers(["A1", "B1", "C1"])
  end
end
