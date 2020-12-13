require 'minitest/autorun'
require 'minitest/pride'
require './lib/game'
require './lib/board_setup'

class GameTest < MiniTest::Test
  def test_it_exists
    game = Game.new

    assert_instance_of Game, game
  end

  def test_it_has_readable_attributes
    game = Game.new

    assert_instance_of BoardSetup ,game.board_setup
  end
end
