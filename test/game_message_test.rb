require 'minitest/autorun'
require 'minitest/pride'
require './lib/game_message'

class GameMessageTest < MiniTest::Test
  def test_it_exists
    game_message = GameMessage.new

    assert_instance_of GameMessage, game_message
  end
end
