require 'minitest/autorun'
require 'minitest/pride'
require './lib/board'
require './lib/cell'
require './lib/ship'
require './lib/game_setup'
require 'pry'

class GameSetupTest < MiniTest::Test
  def test_it_exists
    game_setup = GameSetup.new

    assert_instance_of GameSetup, game_setup
  end

  def test_it_has_readable_attributes
    game_setup = GameSetup.new
    board = Board.new

    assert_equal Board.new.render, game_setup.board.render  
  end

  def test_if_computer_can_place_ships
    skip
    game_setup = GameSetup.new
    game_setup.computer_place_ship_cruiser
    expect = 1

    assert_equal expect, game_setup.board.render
  end

  def test_if_computer_can_select_random_cells
    game_setup = GameSetup.new
    board = Board.new

    assert_equal @board.cells.keys.sample, game_setup.computer_select_cell
  end

end
