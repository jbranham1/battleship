require "./lib/board_setup"
require './lib/game_message'
require 'pry'
class Game
  attr_reader :game_message,
              :computer_board,
              :player_board,
              :computer_cruiser,
              :computer_sub,
              :player_cruiser,
              :player_sub

  def initialize
    @game_message = GameMessage.new
    @computer_board = BoardSetup.new
    @player_board = BoardSetup.new
    @computer_cruiser = Ship.new("Cruiser", 3)
    @computer_sub = Ship.new("Submarine", 2)
    @player_cruiser = Ship.new("Cruiser", 3)
    @player_sub = Ship.new("Submarine", 2)
  end

  def game_start
    computer_place_ships
    @game_message.computer_board_placement(computer_board.board)
    player_place_ships
    take_turn
  end

  def computer_place_ships
    @computer_board.computer_place_ship(computer_cruiser)
    @computer_board.computer_place_ship(computer_sub)
  end

  def player_place_ships
    player_valid_entry(@player_cruiser)
    player_valid_entry(@player_sub)
  end

  def player_valid_entry(ship)
    @game_message.player_ship_placement(ship.name, ship.length)
    loop do
      player_coordinates = gets.chomp.upcase.split
      if !@player_board.player_place_ship(ship, player_coordinates).nil?
        @game_message.player_board_placement(@player_board.board)
        break
      else
        @game_message.invalid_input_for_coordinates
      end
    end
  end

  def take_turn
    @game_message.show_boards(@computer_board.board, @player_board.board)
    player_shot
  end

  def player_shot
    @game_message.enter_shot
    loop do
      player_coordinate = gets.chomp.upcase
      if @player_board.board.valid_coordinate?(player_coordinate) &&
        analyze_shot(player_coordinate)
        break
      else
        @game_message.invalid_input_for_shot
      end
    end
  end

  def analyze_shot(coordinate)
    if @computer_board.board.cells[coordinate].fired_upon?
      @game_message.already_fired_on
      false
    else
      @computer_board.board.cells[coordinate].fire_upon
      true
    end
  end
end
