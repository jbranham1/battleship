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
    board = Board.new

    assert_equal Board.new.render, board_setup.board.render
  end

  def test_if_computer_can_place_ships
    skip
    board_setup = BoardSetup.new
    board_setup.computer_place_ship_cruiser
    expect = 1

    assert_equal expect, board_setup.board.render
  end

  def test_if_computer_can_select_random_cells
    skip
    board_setup = BoardSetup.new
    board = Board.new

    assert_equal @board.cells.keys.sample, board_setup.computer_select_cell
  end

end
