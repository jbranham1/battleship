require "./lib/cell"

class Board
  attr_reader :cells

  def initialize
    @cells = {
      "A1" => Cell.new("A1"),
      "A2" => Cell.new("A2"),
      "A3" => Cell.new("A3"),
      "A4" => Cell.new("A4"),
      "B1" => Cell.new("B1"),
      "B2" => Cell.new("B2"),
      "B3" => Cell.new("B3"),
      "B4" => Cell.new("B4"),
      "C1" => Cell.new("C1"),
      "C2" => Cell.new("C2"),
      "C3" => Cell.new("C3"),
      "C4" => Cell.new("C4"),
      "D1" => Cell.new("D1"),
      "D2" => Cell.new("D2"),
      "D3" => Cell.new("D3"),
      "D4" => Cell.new("D4")
    }
  end

  def valid_coordinate?(coordinate)
    @cells.key?(coordinate)
  end

  def valid_placement?(ship, coordinates)
    if ship.length == coordinates.length &&
      coordinates.all? {|coordinate| valid_coordinate?(coordinate)} &&
      coordinates.all? {|coordinate| @cells[coordinate].empty?}
      consecutive?(coordinates)
    else
      false
    end
  end

  def set_letters(coordinates)
    (coordinates[0][0]..coordinates[-1][0]).to_a
  end

  def set_numbers(coordinates)
    (coordinates[0][1]..coordinates[-1][1]).to_a
  end

  def consecutive?(coordinates)
    letters = set_letters(coordinates)
    numbers = set_numbers(coordinates)
    if letters.all?(coordinates[0][0])
      numbers.size == coordinates.size
    elsif numbers.all?(coordinates[0][1])
      letters.size == coordinates.size
    else
      false
    end
  end

  def place(ship, coordinates)
    if valid_placement?(ship, coordinates)
      coordinates.each do |coordinate|
        @cells[coordinate].place_ship(ship)
      end
    end
  end

  def render
    board_values = convert_cell_values_to_string
    "  1 2 3 4 \n" +
    "A  #{board_values[0]}" +
    "B  #{board_values[1]}" +
    "C  #{board_values[2]}" +
    "D  #{board_values[3]}"
  end

  def convert_cell_values_to_string
    render_cell_values.map {|value| "#{value.join(" ")} \n"}
  end

  def render_cell_values
    @cells.values.map do |cell|
      cell.render
    end.each_slice(4).to_a
  end
end
