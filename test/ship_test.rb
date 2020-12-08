require 'minitest/autorun'
require 'minitest/pride'
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

  def test_if_ship_has_sunk?
    ship = Ship.new('Cruiser', 3)
    assert_equal false, ship.sunk?

    ship.hit
    ship.hit
    ship.hit
    assert_equal true, ship.sunk?
  end

  def test_if_ship_has_been_hit
    ship = Ship.new('Cruiser', 3)
    assert_equal 3, ship.health

    ship.hit
    assert_equal 2, ship.health
  end
end
