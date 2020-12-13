class GameMessage
  def computer_board_placement(computer_board)
    puts "I have laid out my ships on the grid."
    puts "You now need to lay out your two ships."
    puts "The Cruiser is three units long and the Submarine is two units long."
    computer_board.render
  end

  def player_ship_placement(ship_name, ship_length)
    puts "Enter the squares for the #{ship_name} (#{ship_length} spaces):"
  end

  def invalid_input_for_coordinates
    puts "Those are invalid coordinates. Please try again:"
  end

  def player_board_placement(player_board)
    puts player_board.render(true)
  end

  def show_boards(computer_board, player_board)
    puts "========================================"
    puts "=============COMPUTER BOARD============="
    puts computer_board.render
    puts "==============PLAYER BOARD=============="
    puts player_board.render(true)
  end

  def enter_shot
    puts "Enter the coordinate for your shot:"
  end

  def invalid_input_for_shot
    puts "Please enter a valid coordinate:"
  end

  def already_fired_on
    puts "This cell has already been fired upon. Try again:"
  end

  def player_results(coordinate, render_value)
    result = get_render_result(render_value)
    puts "Your shot on #{coordinate} was a #{result}."
  end

  def computer_results(coordinate, render_value)
    result = get_render_result(render_value)
    puts "My shot on #{coordinate} was a #{result}."
  end

  def get_render_result(render_value)
    if render_value == "M"
      "miss"
    elsif render_value == "H"
      "hit"
    elsif render_value == "X"
      "sink"
    end
  end

  def end_game_result(winner)
    if winner == :player
      puts "You won!"
    else
      puts "I won!"
    end
  end
end
