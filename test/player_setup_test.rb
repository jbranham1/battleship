require 'minitest/autorun'
require 'minitest/pride'
require './lib/player_setup'

class PlayerSetupTest < MiniTest::Test
  def test_it_exists
    player_setup = PlayerSetup.new

    assert_instance_of PlayerSetup, player_setup
  end
end
