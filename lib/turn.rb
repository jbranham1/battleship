class Turn
  def initialize
    @game_message = GameMessage.new
  end

  def player_shot(computer_board)
    @computer_board = computer_board
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

  def player_coordinate
    @player_coordinate
  end

  def computer_coordinate
    @computer_coordinate
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

  def computer_shot(player_board)
    loop do
      @computer_coordinate = player_board.cells.keys.shuffle.shift
      if player_board.valid_coordinate?(@computer_coordinate) &&
        !player_board.cells[@computer_coordinate].fired_upon?
        player_board.cells[@computer_coordinate].fire_upon
        break
      end
    end
  end

end
