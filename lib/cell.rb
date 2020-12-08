class Cell
  attr_reader :coordinate, :ship

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
  end

  def empty?
    @ship == nil
  end

  def place_ship(ship)
    @ship = ship
  end

  def render(show_ship = false)
    if show_ship
      "S"
    elsif fire_upon
      if empty?
        "."
      elseif
        "H"
      end
    end
  end
end
