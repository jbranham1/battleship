require "./lib/cell"

class Board
  attr_reader :cells,
              :user_input_cells

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
    @user_input_cells = {}
  end

  def add_cells(num_input)
    add_keys(num_input).each do |key|
      @user_input_cells[key] = Cell.new(key)
    end
    @user_input_cells
  end

  def add_keys(num_input)
    add_keys_horizontal(num_input).each_with_object([]) do |letter, new_keys|
        num_input.times do |index|
          new_keys << "#{letter}#{index+1}"
        end
    end
  end

  def add_keys_horizontal(num_input)
    @alphabet = ["A", "B", "C", "D", "E", "F", "G", "H", "I",
      "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T",
      "U", "V", "W", "X", "Y", "Z"]
    @new_array = []
    @alphabet.each_with_index do |letter, index|
      if index < num_input
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
      consecutive?(coordinates.sort)
    else
      false
    end
  end

  def check_validation(ship, coordinates)
    ship.length == coordinates.length &&
      coordinates.all? {|coordinate| valid_coordinate?(coordinate)} &&
      coordinates.all? {|coordinate| @cells[coordinate].empty?}
  end

  def letters(coordinates)
    (coordinates[0][0]..coordinates[-1][0]).to_a
  end

  def numbers(coordinates)
    num = coordinates.map do |coordinate|
      coordinate[1]
    end.sort
    (num[0]..num[-1]).to_a
  end

  def consecutive?(coordinates)
    if letters(coordinates).all?(coordinates[0][0])
      numbers(coordinates).size == coordinates.size
    elsif numbers(coordinates).all?(coordinates[0][1])
      letters(coordinates).size == coordinates.size
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

  def render(show_ship = false)
    @show_ship = show_ship
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
      cell.render(@show_ship)
    end.each_slice(4).to_a
  end

  def render_user_input_cell_values(num_input)
    @user_input_cells.values.map do |cell|
      cell.render(@show_ship)
    end.each_slice(num_input).to_a
  end

  def convert_user_input_cell_values_to_string(num_input)
    render_user_input_cell_values(num_input).map {|value| "#{value.join("  ")} \n"}
  end

  def render_user_cells(num_input, show_ship = false)
    @show_ship = show_ship
    board_values = convert_user_input_cell_values_to_string(num_input)
    num = 1
    board_string = build_render_header(num_input)

    while num <= num_input do
      board_string += "#{@alphabet[num-1]}  #{board_values[num-1]}"
      num += 1
    end
    board_string
    # "B  #{board_values[1]}" +
    # "C  #{board_values[2]}" +
    # "D  #{board_values[3]}"
  end

  def build_render_header(num_input)
    board_string = "  "
    num_input.times do |index|
      if index < 9
        board_string += "#{index+1}  "
      else
        board_string += "#{index+1} "
      end
    end
    board_string += "\n"
  end
end
