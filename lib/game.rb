require "./lib/board_setup"

class Game
  attr_reader :board_setup
  def initialize
    @board_setup = BoardSetup.new
  end
end
