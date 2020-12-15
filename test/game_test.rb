require 'minitest/autorun'
require 'minitest/pride'
require './lib/game'
require './lib/board'
require './lib/ship'
require './lib/board_setup'
require './lib/game_message'
require 'mocha/minitest'

class GameTest < MiniTest::Test
  def test_it_exists
    game = Game.new

    assert_instance_of Game, game
  end

  def test_it_has_readable_attributes
    game = Game.new
    assert_instance_of GameMessage, game.game_message
    assert_instance_of Board, game.computer_board
    assert_instance_of Board, game.player_board
    assert_instance_of BoardSetup, game.board_setup
    assert_instance_of Ship, game.computer_cruiser
    assert_instance_of Ship, game.computer_sub
    assert_instance_of Ship, game.player_cruiser
    assert_instance_of Ship, game.player_sub
  end

  def test_game_over?
    game = Game.new
    # computer_cruiser = mock
    # computer_sub = mock
    # player_cruiser = mock
    # player_sub = mock
    #
    # computer_cruiser.stubs(:sunk?).returns(true)
    # computer_sub.stubs(:sunk?).returns(true)
    # player_cruiser.stubs(:sunk?).returns(true)
    # player_sub.stubs(:sunk?).returns(true)

    game.stubs(:game_over?).returns(true)

    # assert_equal true, game.game_over?
  end

  def test_computer_ships_sunk
    game = Game.new
    computer_cruiser = mock
    computer_sub = mock
    computer_cruiser.stubs(:sunk?).returns(true)
    computer_sub.stubs(:sunk?).returns(false)

    game.stubs(:computer_ships_sunk?).returns(true)

  end

end
