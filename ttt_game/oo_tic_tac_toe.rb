require 'pry'

class Board
  
  attr_accessor :spaces
  
  def initialize
    @spaces = {}
  end
  
  def build_board(s)
#    system 'clear'
    puts " #{s[1]} | #{s[2]} | #{s[3]} "
    puts "---+---+---"
    puts " #{s[4]} | #{s[5]} | #{s[6]} "
    puts "---+---+---"
    puts " #{s[7]} | #{s[8]} | #{s[9]} "
  end
  
  def create_spaces
    (1...10).each{|position| spaces[position] = position}
  end
  
  def display
    create_spaces
    build_board(spaces)
  end
end

class Game
  attr_accessor :board
  
  def initialize
    @board = Board.new
  end
  
  def play
    board.display
    @board.spaces[1] = "X"
    @board.spaces[2] = "O"
    board.display
  end
end

Game.new.play