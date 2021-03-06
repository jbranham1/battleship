require "./lib/cell"
require './lib/placement_validation'

class Board
  attr_reader :cells,
              :user_input_cells,
              :board_size

  def initialize(board_size = 4)
    @board_size = board_size
    @cells = {}
    add_cells
    @placement_validation = PlacementValidation.new
  end

  def add_cells
    add_keys.map do |key|
      @cells[key] = Cell.new(key)
    end
  end

  def add_keys
    add_keys_horizontal.each_with_object([]) do |letter, new_keys|
        @board_size.times do |index|
          new_keys << "#{letter}#{index+1}"
        end
    end
  end

  def add_keys_horizontal
    @alphabet = ("A".."Z").to_a
    @new_array = []
    @alphabet.each_with_index do |letter, index|
      if index < @board_size
        @new_array.push("#{letter}")
      end
    end
    @new_array
  end

  def valid_coordinate?(coordinate)
    @cells.key?(coordinate)
  end

  def valid_placement?(ship, coordinates)
    if check_validation(ship, coordinates)
      @placement_validation.consecutive?(coordinates.sort)
    else
      false
    end
  end

  def check_validation(ship, coordinates)
    ship.length == coordinates.length &&
      coordinates.all? {|coordinate| valid_coordinate?(coordinate)} &&
      coordinates.all? {|coordinate| @cells[coordinate].empty?}
  end

  def place(ship, coordinates)
    if valid_placement?(ship, coordinates)
      coordinates.each do |coordinate|
        @cells[coordinate].place_ship(ship)
        ship
      end
    end
  end

  def render_cell_values
    @cells.values.map do |cell|
      cell.render(@show_ship)
    end.each_slice(@board_size).to_a
  end

  def convert_cell_values_to_string
    render_cell_values.map {|value| "#{value.join("  ")} \n"}
  end

  def render(show_ship = false)
    @show_ship = show_ship
    board_values = convert_cell_values_to_string
    build_render_header + build_render_body(board_values)
  end

  def build_render_body(board_values)
    num = 1
    board_string = ""
    while num <= @board_size do
      board_string += "#{@alphabet[num-1]}  #{board_values[num-1]}"
      num += 1
    end
    board_string
  end

  def build_render_header
    board_string = "  "
    @board_size.times do |index|
      if index < 9
        board_string += "#{index+1}  "
      else
        board_string += "#{index+1} "
      end
    end
    board_string += "\n"
  end
end
