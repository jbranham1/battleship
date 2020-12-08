require 'minitest/autorun'
require 'minitest/pride'
require './lib/cell'
require './lib/ship'

class CellTest < MiniTest::Test
  def test_it_exists
    cell = Cell.new("B4")

    assert_instance_of Cell, cell
  end

  def test_if_ship_in_cell
    cell = Cell.new("B4")

    assert_nil cell.ship
  end

  def test_if_cell_empty
    cell = Cell.new("B4")

    assert_equal true, cell.empty?
  end

  def test_place_ship
    ship = Ship.new("Cruiser", 3)
    cell = Cell.new("B4")
    cell.place_ship(ship)

    assert_equal false, cell.empty?
    assert_equal ship, cell.ship
  end
end