class GameMessage
  def get_board_size
    puts "Please enter your board size. (Numbers 1-27)"
    loop do
      @number = gets.chomp.to_i
      if @number > 27 || @number < 1
        puts "Invalid board size. Please enter a number between 1 and 27."
      else
        break
      end
    end
    @number
  end

  def computer_board_placement
    puts "I have laid out my ships on the grid."
    sleep(1)
    puts "You now need to lay out your ships."
    sleep(1)
    puts "The Cruiser is three units long and the Submarine is two units long."
  end

  def player_ships
    puts "============"
    puts "Player Ships"
  end

  def get_ship_name
    puts "Please enter the name of your ship:"
  end

  def get_ship_length
    puts "Please enter the length of your ship:"
  end

  def player_ship_placement(ship_name, ship_length)
    sleep(1)
    puts "Enter the squares for #{ship_name} (#{ship_length} spaces):"
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
    sleep(1)
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
    puts "Your shot on #{coordinate} was a #{get_render_result(render_value)}."
  end

  def computer_results(coordinate, render_value)
    puts "My shot on #{coordinate} was a #{get_render_result(render_value)}."
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
    elsif winner == :computer
      puts "I won!"
    else
      "It's a tie, how boring! Goodbye."
    end
  end
end
