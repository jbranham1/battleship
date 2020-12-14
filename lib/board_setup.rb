class BoardSetup
  def computer_select_cells(board,length)
    randomized_cells = board.cells.keys.shuffle
    spaces = randomized_cells.shift(length)
  end

  def computer_place_ship(board, ship)
    loop do
      coordinates = computer_select_cells(board, ship.length)
      if !board.place(ship, coordinates).nil?
        break
      end
    end
  end

  def player_place_ship(board, ship, coordinates)
    board.place(ship, coordinates)
  end
end
