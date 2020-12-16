require "./lib/board_setup"
require "./lib/game_message"
require "./lib/board"
require "./lib/ship"
require "./lib/player_setup"

class Game
  def initialize
    @game_message = GameMessage.new
    @board_setup = BoardSetup.new
    @computer_cruiser = Ship.new("Cruiser", 3)
    @computer_sub = Ship.new("Submarine", 2)
    @player_setup = PlayerSetup.new
  end

  def game_start
    setup
    computer_place_ships
    @game_message.computer_board_placement
    @game_message.player_board_placement(@player_board)
    player_place_ships
    take_turn
  end

  def setup
    board_length = @game_message.get_board_size
    @player_setup.get_ships(board_length)
    @player_ships = @player_setup.ships
    @computer_board = Board.new(board_length)
    @player_board = Board.new(board_length)
  end

  def computer_place_ships
    @board_setup.computer_place_ship(@computer_board, @computer_cruiser)
    @board_setup.computer_place_ship(@computer_board, @computer_sub)
  end

  def player_place_ships
    @player_ships.each do |ship|
      player_valid_entry(ship)
    end

  end

  def player_valid_entry(ship)
    @game_message.player_ship_placement(ship.name, ship.length)
    loop do
      player_coordinates = gets.chomp.upcase.split
      if !@player_board.place(ship, player_coordinates).nil?
        @game_message.player_board_placement(@player_board)
        break
      else
        @game_message.invalid_input_for_coordinates
      end
    end
  end

  def take_turn
    while !game_over?
      @game_message.show_boards(@computer_board, @player_board)
      player_shot
      computer_shot
      @game_message.player_results(@player_coordinate,
        @computer_board.cells[@player_coordinate].render)
      @game_message.computer_results(@computer_coordinate,
        @player_board.cells[@computer_coordinate].render)
    end
    @game_message.end_game_result(game_winner)
  end

  def player_shot
    @game_message.enter_shot
    loop do
      @player_coordinate = gets.chomp.upcase
      if @computer_board.valid_coordinate?(@player_coordinate) &&
        player_analyze_shot(@player_coordinate)
        break
      else
        @game_message.invalid_input_for_shot
      end
    end
  end

  def player_analyze_shot(coordinate)
    if @computer_board.cells[coordinate].fired_upon?
      @game_message.already_fired_on
      false
    else
      @computer_board.cells[coordinate].fire_upon
      true
    end
  end

  def computer_shot
    loop do
      @computer_coordinate = @player_board.cells.keys.shuffle.shift
      if @player_board.valid_coordinate?(@computer_coordinate) &&
        !@player_board.cells[@computer_coordinate].fired_upon?
        @player_board.cells[@computer_coordinate].fire_upon
        break
      end
    end
  end

  def game_over?
    computer_ships_sunk? || player_ships_sunk?
  end

  def computer_ships_sunk?
    @computer_cruiser.sunk? && @computer_sub.sunk?
  end

  def player_ships_sunk?
    @player_ships.all? do |ship|
      ship.sunk?
    end
  end

  def game_winner
    if computer_ships_sunk? && player_ships_sunk?
      :tie
    elsif computer_ships_sunk?
      :player
    elsif player_ships_sunk?
      :computer
    end
  end
end
