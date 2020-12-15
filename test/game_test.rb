require 'minitest/autorun'
require 'minitest/pride'
require './lib/game'
require './lib/board'
require './lib/ship'
require './lib/board_setup'
require './lib/game_message'

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
end
