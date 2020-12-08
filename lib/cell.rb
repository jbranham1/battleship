class Cell
  attr_reader :coordinate,
              :ship,
              :fired_upon

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @fired_upon = false
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


  def fire_upon
    @fired_upon = true
    if @ship != nil
      @ship.hit
    end
  end
end
