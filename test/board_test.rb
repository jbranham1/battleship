require 'minitest/autorun'
require 'minitest/pride'
require './lib/board'
require './lib/cell'
require './lib/ship'
require 'pry'

class BoardTest < MiniTest::Test
  def test_it_exists
    board = Board.new

    assert_instance_of Board, board
  end

  def test_it_has_readable_attributes
    board = Board.new

    assert_equal 16, board.cells.count
    assert_equal Hash, board.cells.class
    assert_equal Cell, board.cells.values[1].class
  end

  def test_valid_coordinate?
    board = Board.new

    assert_equal true, board.valid_coordinate?("A1")
    assert_equal false, board.valid_coordinate?("E1")
  end

  def test_valid_placement_for_length
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)

    assert_equal false, board.valid_placement?(cruiser, ["A1", "A2"])
    assert_equal true, board.valid_placement?(cruiser, ["A1", "A2", "A3"])
  end

  def test_valid_placement_horizontal
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)

    assert_equal false, board.valid_placement?(cruiser, ["A1", "A2", "A4"])
    assert_equal false, board.valid_placement?(cruiser, ["A1", "A2", "B3"])
    assert_equal true, board.valid_placement?(cruiser, ["A1", "A2", "A3"])
  end

  def test_valid_placement_vertical
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)

    assert_equal false, board.valid_placement?(cruiser, ["A1", "B2", "C4"])
    assert_equal false, board.valid_placement?(cruiser, ["A1", "B1", "D1"])
    assert_equal true, board.valid_placement?(cruiser, ["A1", "B1", "C1"])
  end

  def test_valid_placement_diagonal
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)

    assert_equal false, board.valid_placement?(cruiser, ["A1", "B2", "C3"])
  end

  def test_valid_placement_unordered
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)

    assert_equal true, board.valid_placement?(cruiser, ["A1", "A3", "A2"])
  end

  def test_check_validation
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)

    assert_equal true, board.check_validation(cruiser, ["A1", "B2", "C3"])
    assert_equal false, board.check_validation(cruiser, ["A1", "B2"])
  end

  def test_consecutive_horizontal
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    assert_equal false, board.consecutive?(["A1", "A2", "A4"])
    assert_equal false, board.consecutive?(["A1", "A2", "B3"])
    assert_equal true, board.consecutive?(["A1", "A2", "A3"])
  end

  def test_consecutive_vertical
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)

    assert_equal false, board.consecutive?(["A1", "B2", "C4"])
    assert_equal false, board.consecutive?(["A1", "B1", "D1"])
    assert_equal true, board.consecutive?(["A1", "B1", "C1"])
  end

  def test_letters
    board = Board.new
    letters = ["A"]
    assert_equal letters, board.letters(["A1", "A2", "A3"])

    letters = ["A", "B", "C"]
    assert_equal letters, board.letters(["A1", "B2", "C3"])
  end

  def test_numbers
    board = Board.new
    numbers = ["1","2","3"]
    assert_equal numbers, board.numbers(["A1", "A2", "A3"])

    numbers = ["1"]
    assert_equal numbers, board.numbers(["A1", "B1", "C1"])
  end

  def test_place_ship
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)

    board.place(cruiser, ["A1", "A2", "A3"])
    cell_1 = board.cells["A1"]
    cell_2 = board.cells["A2"]
    cell_3 = board.cells["A3"]

    assert_equal cruiser, cell_1.ship
    assert_equal cruiser, cell_2.ship
    assert_equal cruiser, cell_3.ship
  end

  def test_place_overlapping_ships
    board = Board.new
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
    board = Board.new

    empty_board = "  1 2 3 4 \n" +
                  "A  . . . . \n" +
                  "B  . . . . \n" +
                  "C  . . . . \n" +
                  "D  . . . . \n"

    assert_equal  empty_board, board.render
  end

  def test_board_render_hit
    board = Board.new
    ship = Ship.new("Cruiser", 3)
    cell = Cell.new("A1")
    board.place(ship, ["A1", "A2", "A3"])
    board.cells["A1"].fire_upon

    hit_board = "  1 2 3 4 \n" +
                  "A  H . . . \n" +
                  "B  . . . . \n" +
                  "C  . . . . \n" +
                  "D  . . . . \n"

    assert_equal  hit_board, board.render
  end

  def test_board_render_miss
    board = Board.new
    ship = Ship.new("Cruiser", 3)
    cell = Cell.new("A1")
    board.place(ship, ["A1", "A2", "A3"])
    board.cells["B1"].fire_upon

    miss_board = "  1 2 3 4 \n" +
                  "A  . . . . \n" +
                  "B  M . . . \n" +
                  "C  . . . . \n" +
                  "D  . . . . \n"

    assert_equal  miss_board, board.render
  end

  def test_board_render_sunk
    board = Board.new
    ship = Ship.new("Cruiser", 3)
    cell = Cell.new("A1")
    board.place(ship, ["A1", "A2", "A3"])
    board.cells["A1"].fire_upon
    board.cells["A2"].fire_upon
    board.cells["A3"].fire_upon

    sunk_board = "  1 2 3 4 \n" +
                  "A  X X X . \n" +
                  "B  . . . . \n" +
                  "C  . . . . \n" +
                  "D  . . . . \n"

    assert_equal  sunk_board, board.render
  end

  def test_board_render_show_ship
    board = Board.new

    show_ship_board = "  1 2 3 4 \n" +
                  "A  . . . . \n" +
                  "B  . . . . \n" +
                  "C  . . . . \n" +
                  "D  . . . . \n"

    #assert_equal  show_ship_board, board.render
  end

  def test_render_cell_values
    board = Board.new
    expected_cell_values = [[".", ".", ".", "."], [".", ".", ".", "."],
    [".", ".", ".", "."], [".", ".", ".", "."]]

    assert_equal expected_cell_values, board.render_cell_values
  end

  def test_convert_cell_values_to_string
    board = Board.new
    expected_cell_values = [". . . . \n",
                            ". . . . \n",
                            ". . . . \n",
                            ". . . . \n"]

    assert_equal expected_cell_values, board.convert_cell_values_to_string
    assert_instance_of String, board.convert_cell_values_to_string[0]
  end
end
