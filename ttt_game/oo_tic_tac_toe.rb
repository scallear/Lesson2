class Board
  WINNING_LINES = [[1,2,3], [4,5,6], [7,8,9], [1,4,7], [2,5,8], [3,6,9], [1,5,9], [3,5,7]]
  
  attr_accessor :data
  
  def initialize
    @data = {}
    (1...10).each {|position| @data[position] = Square.new(position)}
  end
  
  def draw
    system 'clear'
    puts " #{@data[1].value} | #{@data[2].value} | #{@data[3].value} "
    puts "---+---+---"
    puts " #{@data[4].value} | #{@data[5].value} | #{@data[6].value} "
    puts "---+---+---"
    puts " #{@data[7].value} | #{@data[8].value} | #{@data[9].value} "
  end
  
  def all_marked?
    empty_position.size == 0
  end
  
  def empty_position
    @data.select{|key, square| square.value.is_a? Numeric}.keys
  end

  def mark_square(position, marker)
    @data[position].value = marker
  end
  
  def winning_condition(marker)
    WINNING_LINES.each do |line|
      counter = 0
      line.each do |space| 
        counter += 1 if @data[space].value == marker
      end
       return true if counter == 3
    end
    false
  end

  def check_two(marker)
    WINNING_LINES.each do |line|
      counter = 0
      line.each do |space| 
        counter += 1 if @data[space].value == marker
      end
      return line if counter == 2
    end
    nil
  end
end

class Square
  attr_accessor :value
  
  def initialize(value)
    @value = value
  end
end

class Player
  attr_reader :name, :marker
  
  def initialize(name, marker)
    @name = name
    @marker = marker
  end
end

class TicTacToe
  
  def initialize
    @board = Board.new
    create_players
  end

  def create_players
    system 'clear'
    
    puts "Welcome to Tic Tac Toe!\nWhat's your name?"
    name = gets.chomp.capitalize
    
    begin
      puts "Choose your side, X or O:"
      marker = gets.chomp.upcase
    end until marker == "O" || marker == "X"
    
    marker == "X"? computer_marker = "O" : computer_marker = "X"
    
    @user = Player.new(name, marker)
    @computer = Player.new("Computer", computer_marker)
    
    @user.marker == "X"? @current_player = @user : @current_player = @computer
  end

  def computer_choice
    attack = @board.check_two(@computer.marker)
    defence = @board.check_two(@user.marker)
    
    if attack
      choice = attack.select {|option| @board.data[option].value.is_a? Numeric}.first
      if !@board.empty_position.include?(choice)
        choice = @board.empty_position.sample
      end
    elsif defence
      choice = defence.select {|option| @board.data[option].value.is_a? Numeric}.first
      if !@board.empty_position.include?(choice)
        choice = @board.empty_position.sample
      end
    else
      choice = @board.empty_position.sample
    end
    choice
  end

  def current_player_marks_square
    if @current_player == @user
      begin
        puts "Choose a position (1-9):"
        position = gets.chomp.to_i
      end until @board.empty_position.include?(position)
    else
      position = computer_choice
    end
    @board.mark_square(position, @current_player.marker)
  end
  
  def alternate_player
    if @current_player == @user
      @current_player = @computer
    else
      @current_player = @user
    end
  end
  
  def replay
    begin
      puts "Play again? (y/n)"
      answer = gets.chomp.downcase
    end until answer == "y" || answer == "n"
    
    reset if answer == "y"
    
    answer
  end
  
  def reset
    @board = Board.new 
    @user.marker == "X"? @current_player = @user : @current_player = @computer
  end
  
  def play
    begin
      @board.draw
      puts "X goes first!"
      
      loop do
        current_player_marks_square
        @board.draw
        if @board.winning_condition(@current_player.marker)
          puts "#{@current_player.name} won!"
          break
        elsif @board.all_marked?
          puts "It's a tie."
          break
        else
          alternate_player
        end
      end
    end until replay == "n"
    
    puts "Thanks for playing!"
  end
  
end

TicTacToe.new.play
