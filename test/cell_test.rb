require 'minitest/autorun'
require 'minitest/pride'
require './lib/cell'
require './lib/ship'

class CellTest < MiniTest::Test
  def test_it_exists
    cell = Cell.new("B4")

    assert_instance_of Cell, cell
  end

  def test_it_has_readable_attributes
    cell = Cell.new("B4")
    ship = Ship.new('Cruiser', 3)
    assert_equal 'B4', cell.coordinate
    assert_nil cell.ship
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

  def test_if_cell_fired_upon
    ship = Ship.new('Cruiser', 3)
    cell = Cell.new("B4")
    cell.place_ship(ship)
    assert_equal false, cell.fired_upon?

    cell.fire_upon

    assert_equal true, cell.fired_upon?
  end

  def test_ship_health
    ship = Ship.new("Cruiser", 3)
    cell = Cell.new("B4")
    cell.place_ship(ship)
    assert_equal 3, cell.ship.health

    cell.fire_upon

    assert_equal 2, cell.ship.health
  end

  def test_render_for_not_fired_upon
    cell = Cell.new("B4")

    assert_equal ".", cell.render
  end

  def test_render_for_fired_upon_with_no_ship
    cell = Cell.new("B4")

    assert_equal ".", cell.render
    cell.fire_upon

    assert_equal "M", cell.render
  end

  def test_render_for_fired_upon_with_ship
    ship = Ship.new("Cruiser", 3)
    cell = Cell.new("B4")
    cell.place_ship(ship)
    assert_equal ".", cell.render
    cell.fire_upon

    assert_equal "H", cell.render
  end

  def test_render_for_fired_upon_sunk
    ship = Ship.new("Cruiser", 3)
    cell = Cell.new("B4")
    cell.place_ship(ship)
    cell.fire_upon
    2.times do
      ship.hit
    end

    assert_equal true, ship.sunk?
    assert_equal "X", cell.render
  end

  def test_render_has_optional_argument
    ship = Ship.new("Cruiser", 3)
    cell = Cell.new("B4")

    assert_equal ".", cell.render(true)
    cell.place_ship(ship)

    assert_equal "S", cell.render(true)
  end

  def test_render_has_optional_argument_and_hit
    ship = Ship.new("Cruiser", 3)
    cell = Cell.new("B4")

    assert_equal ".", cell.render(true)
    cell.place_ship(ship)
    cell.fire_upon

    assert_equal "H", cell.render(true)
  end

  def test_render_has_optional_argument_and_sunk
    ship = Ship.new("Cruiser", 3)
    cell = Cell.new("B4")
    cell.place_ship(ship)
    cell.fire_upon
    2.times do
      ship.hit
    end

    assert_equal true, ship.sunk?
    assert_equal "X", cell.render(true)
  end
end
