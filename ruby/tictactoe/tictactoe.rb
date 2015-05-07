# Rough, quick approximation of a tic-tac-toe game?

# example1:
# |x|o|x|
# -------
# |o|x|x|
# -------
# |o|x|o|

class Point
  def initialize(x, y)
    @x = x
    @y = y
    @token = nil
  end
  attr_reader :x, :y
  attr_accessor :token

  def to_s
    token || " "
  end
end

class Grid
  def initialize(points = nil)
    @points = points ||= [0,1,2].map { |x|
      [0,1,2].each { |y|
        Point.new(x,y)
      }
    }
  end

  def representation
    "|#{points.select { |point| point.at?(0,0) }}|#{}|#{}|"\
  end

  def select(token, at: {})
    self
  end

  def valid?
    true
  end
end

class Player
  def initialize(number, token)
    @player_number = number
    @token = token
  end

  attr_reader :token
end


class Game
  class InvalidSelectionError < StandardError; end

  def initialize
    @grid = Grid.new
    @player1 = Player.new(1, 'x')
    @player2 = Player.new(2, 'o')
    @active_player = @player1
  end

  def select(x,y)
    grid.select(active_player.token, at: { x: x, y: y})
    return InvalidSelectionError unless grid.valid?
  end

  private
  def next_player
    active_player = active_player == player1 ? player2 : player1
  end

  attr_accessor :active_player
  attr_reader :player1, :player2, :grid
end
