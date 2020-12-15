require 'minitest/autorun'
require 'minitest/pride'
require './lib/board'
require './lib/cell'
require './lib/ship'
require 'pry'

class BoardTest < MiniTest::Test
  def test_it_exists
    board = Board.new(10)

    assert_instance_of Board, board
  end

  def test_it_has_readable_attributes_default
    board = Board.new

    assert_equal 16, board.cells.count
    assert_equal Hash, board.cells.class
    assert_equal 4, board.num_input
  end

  def test_it_has_readable_attributes_for_input
    board = Board.new(10)

    assert_equal 100, board.cells.count
    assert_equal Hash, board.cells.class
    assert_equal 10, board.num_input
  end

  def test_valid_coordinate?
    board = Board.new(10)

    assert_equal true, board.valid_coordinate?("A1")
    assert_equal false, board.valid_coordinate?("Z1")
  end

  def test_valid_placement_for_length
    board = Board.new(10)
    cruiser = Ship.new("Cruiser", 3)

    assert_equal false, board.valid_placement?(cruiser, ["A1", "A2"])
    assert_equal true, board.valid_placement?(cruiser, ["A1", "A2", "A3"])
  end

  def test_valid_placement_horizontal
    board = Board.new(10)
    cruiser = Ship.new("Cruiser", 3)

    assert_equal false, board.valid_placement?(cruiser, ["A1", "A2", "A4"])
    assert_equal false, board.valid_placement?(cruiser, ["A1", "A2", "B3"])
    assert_equal true, board.valid_placement?(cruiser, ["A1", "A2", "A3"])
  end

  def test_valid_placement_vertical
    board = Board.new(10)
    cruiser = Ship.new("Cruiser", 3)

    assert_equal false, board.valid_placement?(cruiser, ["A1", "B2", "C4"])
    assert_equal false, board.valid_placement?(cruiser, ["A1", "B1", "D1"])
    assert_equal true, board.valid_placement?(cruiser, ["A1", "B1", "C1"])
  end

  def test_valid_placement_diagonal
    board = Board.new(10)
    cruiser = Ship.new("Cruiser", 3)

    assert_equal false, board.valid_placement?(cruiser, ["A1", "B2", "C3"])
    assert_equal false, board.valid_placement?(cruiser, ["B3", "C1", "D1"])
  end

  def test_valid_placement_unordered
    board = Board.new(10)
    cruiser = Ship.new("Cruiser", 3)

    assert_equal true, board.valid_placement?(cruiser, ["A1", "A3", "A2"])
  end

  def test_check_validation
    board = Board.new(10)
    cruiser = Ship.new("Cruiser", 3)

    assert_equal true, board.check_validation(cruiser, ["A1", "B2", "C3"])
    assert_equal false, board.check_validation(cruiser, ["A1", "B2"])
  end

  def test_consecutive_horizontal
    board = Board.new(10)
    cruiser = Ship.new("Cruiser", 3)
    assert_equal false, board.consecutive?(["A1", "A2", "A4"])
    assert_equal false, board.consecutive?(["A1", "A2", "B3"])
    assert_equal true, board.consecutive?(["A1", "A2", "A3"])
  end

  def test_consecutive_vertical
    board = Board.new(10)
    cruiser = Ship.new("Cruiser", 3)

    assert_equal false, board.consecutive?(["A1", "B2", "C4"])
    assert_equal false, board.consecutive?(["A1", "B1", "D1"])
    assert_equal true, board.consecutive?(["A1", "B1", "C1"])
  end

  def test_letters
    board = Board.new(10)
    letters = ["A"]
    assert_equal letters, board.letters(["A1", "A2", "A3"])

    letters = ["A", "B", "C"]
    assert_equal letters, board.letters(["A1", "B2", "C3"])
  end

  def test_numbers
    board = Board.new(10)
    numbers = ["1","2","3"]
    assert_equal numbers, board.numbers(["A1", "A2", "A3"])

    numbers = ["1"]
    assert_equal numbers, board.numbers(["A1", "B1", "C1"])
  end

  def test_place_ship
    board = Board.new(10)
    cruiser = Ship.new("Cruiser", 3)

    board.place(cruiser, ["A1", "A2", "A3"])
    cell_1 = board.cells["A1"]
    cell_2 = board.cells["A2"]
    cell_3 = board.cells["A3"]

    assert_equal cruiser, cell_1.ship
    assert_equal cruiser, cell_2.ship
    assert_equal cruiser, cell_3.ship
  end

  def test_place_ship_invalid_placement
    board = Board.new(10)
    cruiser = Ship.new("Cruiser", 3)

    board.place(cruiser, ["A1", "A2", "A4"])
    cell_1 = board.cells["A1"]
    cell_2 = board.cells["A2"]
    cell_3 = board.cells["A3"]

    assert_nil cell_1.ship
    assert_nil cell_2.ship
    assert_nil cell_3.ship
  end


  def test_place_overlapping_ships
    board = Board.new(10)
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    assert_equal true, board.valid_placement?(cruiser, ["A1", "A2", "A3"])
    board.place(cruiser, ["A1", "A2", "A3"])
    cell_1 = board.cells["A1"]
    cell_2 = board.cells["A2"]
    cell_3 = board.cells["A3"]

    assert_equal false, board.valid_placement?(submarine, ["A1", "A2"])
  end

  def test_board_render_empty
    board = Board.new(10)

    empty_board = "  1  2  3  4  5  6  7  8  9  10 \n" +
                    "A  .  .  .  .  .  .  .  .  .  . \n" +
                    "B  .  .  .  .  .  .  .  .  .  . \n" +
                    "C  .  .  .  .  .  .  .  .  .  . \n" +
                    "D  .  .  .  .  .  .  .  .  .  . \n" +
                    "E  .  .  .  .  .  .  .  .  .  . \n" +
                    "F  .  .  .  .  .  .  .  .  .  . \n" +
                    "G  .  .  .  .  .  .  .  .  .  . \n" +
                    "H  .  .  .  .  .  .  .  .  .  . \n" +
                    "I  .  .  .  .  .  .  .  .  .  . \n" +
                    "J  .  .  .  .  .  .  .  .  .  . \n"

    assert_equal  empty_board, board.render
  end

  def test_board_render_hit
    board = Board.new(10)
    ship = Ship.new("Cruiser", 3)
    board.place(ship, ["A1", "A2", "A3"])
    board.cells["A1"].fire_upon

    hit_board =     "  1  2  3  4  5  6  7  8  9  10 \n" +
                    "A  H  .  .  .  .  .  .  .  .  . \n" +
                    "B  .  .  .  .  .  .  .  .  .  . \n" +
                    "C  .  .  .  .  .  .  .  .  .  . \n" +
                    "D  .  .  .  .  .  .  .  .  .  . \n" +
                    "E  .  .  .  .  .  .  .  .  .  . \n" +
                    "F  .  .  .  .  .  .  .  .  .  . \n" +
                    "G  .  .  .  .  .  .  .  .  .  . \n" +
                    "H  .  .  .  .  .  .  .  .  .  . \n" +
                    "I  .  .  .  .  .  .  .  .  .  . \n" +
                    "J  .  .  .  .  .  .  .  .  .  . \n"

    assert_equal  hit_board, board.render
  end

  def test_board_render_miss
    board = Board.new(10)
    ship = Ship.new("Cruiser", 3)
    board.place(ship, ["A1", "A2", "A3"])
    board.cells["B1"].fire_upon

    miss_board =    "  1  2  3  4  5  6  7  8  9  10 \n" +
                    "A  .  .  .  .  .  .  .  .  .  . \n" +
                    "B  M  .  .  .  .  .  .  .  .  . \n" +
                    "C  .  .  .  .  .  .  .  .  .  . \n" +
                    "D  .  .  .  .  .  .  .  .  .  . \n" +
                    "E  .  .  .  .  .  .  .  .  .  . \n" +
                    "F  .  .  .  .  .  .  .  .  .  . \n" +
                    "G  .  .  .  .  .  .  .  .  .  . \n" +
                    "H  .  .  .  .  .  .  .  .  .  . \n" +
                    "I  .  .  .  .  .  .  .  .  .  . \n" +
                    "J  .  .  .  .  .  .  .  .  .  . \n"

    assert_equal  miss_board, board.render
  end

  def test_board_render_sunk
    board = Board.new(10)
    ship = Ship.new("Cruiser", 3)
    board.place(ship, ["A1", "A2", "A3"])
    board.cells["A1"].fire_upon
    board.cells["A2"].fire_upon
    board.cells["A3"].fire_upon

    sunk_board =    "  1  2  3  4  5  6  7  8  9  10 \n" +
                    "A  X  X  X  .  .  .  .  .  .  . \n" +
                    "B  .  .  .  .  .  .  .  .  .  . \n" +
                    "C  .  .  .  .  .  .  .  .  .  . \n" +
                    "D  .  .  .  .  .  .  .  .  .  . \n" +
                    "E  .  .  .  .  .  .  .  .  .  . \n" +
                    "F  .  .  .  .  .  .  .  .  .  . \n" +
                    "G  .  .  .  .  .  .  .  .  .  . \n" +
                    "H  .  .  .  .  .  .  .  .  .  . \n" +
                    "I  .  .  .  .  .  .  .  .  .  . \n" +
                    "J  .  .  .  .  .  .  .  .  .  . \n"

    assert_equal  sunk_board, board.render
  end

  def test_board_render_show_ship
    board = Board.new(10)
    ship = Ship.new("Cruiser", 3)
    board.place(ship, ["A1", "A2", "A3"])
    board.cells["A1"].fire_upon


    show_ship_board = "  1  2  3  4  5  6  7  8  9  10 \n" +
                      "A  H  S  S  .  .  .  .  .  .  . \n" +
                      "B  .  .  .  .  .  .  .  .  .  . \n" +
                      "C  .  .  .  .  .  .  .  .  .  . \n" +
                      "D  .  .  .  .  .  .  .  .  .  . \n" +
                      "E  .  .  .  .  .  .  .  .  .  . \n" +
                      "F  .  .  .  .  .  .  .  .  .  . \n" +
                      "G  .  .  .  .  .  .  .  .  .  . \n" +
                      "H  .  .  .  .  .  .  .  .  .  . \n" +
                      "I  .  .  .  .  .  .  .  .  .  . \n" +
                      "J  .  .  .  .  .  .  .  .  .  . \n"

    assert_equal  show_ship_board, board.render(true)
  end

  def test_render_cell_values
    board = Board.new
    expected_cell_values = [[".", ".", ".", "."], [".", ".", ".", "."],
    [".", ".", ".", "."], [".", ".", ".", "."]]

    assert_equal expected_cell_values, board.render_cell_values(4)
  end

  def test_convert_cell_values_to_string
    board = Board.new(10)
    expected_cell_values = ".  .  .  .  .  .  .  .  .  . \n"


    assert_equal expected_cell_values.chars.count, board.convert_cell_values_to_string[1].chars.count
    assert_instance_of String, board.convert_cell_values_to_string[0]
  end
end
