require "./lib/board_setup"
require "./lib/game_message"
require "./lib/board"
require "./lib/ship"
require "./lib/turn"
require "./lib/player_setup"

class Game
  def initialize
    @game_message = GameMessage.new
    @board_setup = BoardSetup.new
    @computer_cruiser = Ship.new("Cruiser", 3)
    @computer_sub = Ship.new("Submarine", 2)
    @player_setup = PlayerSetup.new
    @turn = Turn.new
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
      take_shots
      shot_results
    end
    @game_message.end_game_result(game_winner)
  end

  def take_shots
    @turn.player_shot(@computer_board)
    @turn.computer_shot(@player_board)
  end

  def shot_results
    @game_message.player_results(@turn.player_coordinate,
      @computer_board.cells[@turn.player_coordinate].render)
    @game_message.computer_results(@turn.computer_coordinate,
      @player_board.cells[@turn.computer_coordinate].render)
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
