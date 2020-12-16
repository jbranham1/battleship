require "./lib/cell"

class Board
  attr_reader :cells,
              :user_input_cells,
              :num_input

  def initialize(num_input = 4)
    @num_input = num_input
    @cells = {}
    add_cells(num_input)
  end

  def add_cells(num_input)
    add_keys(num_input).map do |key|
      @cells[key] = Cell.new(key)
    end
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
    [*(letters_sort(coordinates)[0]..letters_sort(coordinates)[-1])]
  end

  def letters_sort(coordinates)
    coordinates.map do |coordinate|
      coordinate[0]
    end.uniq.sort
  end

  def numbers(coordinates)
    [*(numb_sort(coordinates)[0]..numb_sort(coordinates)[-1])]
  end

  def numb_sort(coordinates)
    nums = coordinates.map do |coordinate|
      if coordinate.chars.count == 2
        coordinate[1].to_i
      elsif coordinate.chars.count > 2
        coordinate[1..-1].to_i
      end
    end
    nums.sort.map {|num| num.to_s}
  end

  def consecutive?(coordinates)
    if letters(coordinates).all?(coordinates[0][0])
      numbers(coordinates).size == coordinates.size
    elsif numbers(coordinates).count == 1
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

  def render_cell_values(num_input)
    @cells.values.map do |cell|
      cell.render(@show_ship)
    end.each_slice(num_input).to_a
  end

  def convert_cell_values_to_string
    render_cell_values(num_input).map {|value| "#{value.join("  ")} \n"}
  end

  def render(show_ship = false)
    @show_ship = show_ship
    board_values = convert_cell_values_to_string
    num = 1
    board_string = build_render_header(num_input)

    while num <= num_input do
      board_string += "#{@alphabet[num-1]}  #{board_values[num-1]}"
      num += 1
    end
    board_string
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
