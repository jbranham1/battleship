require 'minitest/autorun'
require 'minitest/pride'
require './lib/player_setup'
require 'mocha/minitest'

class PlayerSetupTest < MiniTest::Test
  def test_it_exists
    player_setup = PlayerSetup.new

    assert_instance_of PlayerSetup, player_setup
  end

  def test_readable_attributes
    player_setup = PlayerSetup.new

    assert_empty player_setup.player_ships
  end

  def test_generate_computer_ships
    player_setup = PlayerSetup.new

    assert_equal 0, player_setup.generate_computer_ships.count
  end
end
