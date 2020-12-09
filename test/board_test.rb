require 'minitest/autorun'
require 'minitest/pride'
require './lib/board'
require './lib/cell'
require './lib/ship'

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
end
