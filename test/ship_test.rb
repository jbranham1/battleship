require 'minitest'
require 'pride'
require './lib/ship'

class ShipTest < MiniTest::Test

  def test_it_exists
    ship = Ship.new('Cruiser', 3)
    assert_instance_of Ship, ship
  end

  def test_it_has_readable_attributes
    ship = Ship.new('Cruiser', 3)
    assert_equal 'Cruiser', ship.name
    assert_equal 3, ship.length
    assert_equal 3, ship.health
  end

end
