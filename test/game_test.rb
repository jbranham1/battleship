require 'minitest/autorun'
require 'minitest/pride'
require './lib/game'
require 'mocha/minitest'

class GameTest < MiniTest::Test
  def test_it_exists
    game = Game.new

    assert_instance_of Game, game
  end

  def test_game_over?
    game = Game.new
    game.stubs(:computer_ships_sunk?).returns(false)
    game.stubs(:player_ships_sunk?).returns(false)

    assert_equal false, game.game_over?
    game.stubs(:player_ships_sunk?).returns(true)

    assert_equal true, game.game_over?

  end

  def test_computer_ships_sunk
    game = Game.new
    computer_cruiser = mock
    computer_sub = mock
    computer_cruiser.stubs(:sunk?).returns(true)
    computer_sub.stubs(:sunk?).returns(false)

    assert_equal false, game.computer_ships_sunk?
    computer_sub.stubs(:sunk?).returns(true)

    assert_equal false, game.computer_ships_sunk?
  end

  def test_game_winner_player
    game = Game.new

    game.stubs(:computer_ships_sunk?).returns(true)
    game.stubs(:player_ships_sunk?).returns(false)
    assert_equal :player, game.game_winner
  end

  def test_game_winner_computer
    game = Game.new

    game.stubs(:computer_ships_sunk?).returns(false)
    game.stubs(:player_ships_sunk?).returns(true)
    assert_equal :computer, game.game_winner
  end

  def test_game_winner_tie
    game = Game.new

    game.stubs(:computer_ships_sunk?).returns(true)
    game.stubs(:player_ships_sunk?).returns(true)
    assert_equal :tie, game.game_winner
  end
end
