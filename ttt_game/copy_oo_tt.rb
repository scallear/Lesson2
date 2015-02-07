class Player
  
end

class User < Player
  def player_choice(spaces, side)
    puts "Choose a space (1-9):"
    choice = gets.chomp.to_i
    until empty_spaces(spaces).include?(choice)
      puts "Space already taken, choose an empty space:"
      choice = gets.chomp.to_i
    end 
    spaces[choice] = side
  end
end

class Computer < Player
  
  def check_two(spaces)
    choices = nil
    WINNING_LINES.each do |line|
      if spaces.values_at(*line).count("X") == 2
        choices = spaces.values_at(*line).select{|value| value.is_a? Numeric}.first
        break
      elsif spaces.values_at(*line).count("O") == 2
        choices = spaces.values_at(*line).select{|value| value.is_a? Numeric}.first
        break
      end
    end
    return choices
  end
  
  def empty_spaces(spaces)
    spaces.select{|key, value| value.is_a? Numeric}.keys
  end
  
  def computer_choice(spaces, side)
    if check_two(spaces)
      choice = check_two(spaces)
    else
      choice = empty_spaces(spaces).sample
    end
    spaces[choice] = side
  end
end

class Board
  def draw_board(s)
    system 'clear'
    puts " #{s[1]} | #{s[2]} | #{s[3]} "
    puts "---+---+---"
    puts " #{s[4]} | #{s[5]} | #{s[6]} "
    puts "---+---+---"
    puts " #{s[7]} | #{s[8]} | #{s[9]} "
  end
  
  def initialize_spaces
    spaces = {}
    (1...10).each{|position| spaces[position] = position}
    spaces
  end
end

class Game
  WINNING_LINES = [[1,2,3], [4,5,6], [7,8,9], [1,4,7], [2,5,8], [3,6,9], [1,5,9], [3,5,7]]
  
  def initialize
    
  end
  
  def check_win(spaces)
    WINNING_LINES.each do |line| 
      return "X" if spaces.values_at(*line).count("X") == 3
      return "O" if spaces.values_at(*line).count("O") == 3
    end
    nil
  end
  
  def play_again
    puts "Would you like to try again?"
    gets.chomp.upcase
  end
  
  puts "Welcome to Tic-Tac-Toe!"
  
  replay = "Y"
  
  begin
  
  #Choosing sides.................................................
    begin
      puts "Choose your side, X or O:"
        player = gets.chomp.upcase
    end until player == "O" || player == "X"
  
    if player == "O"
      computer = "X"
      puts "You chose O's the computer will be X's. Press [enter] to continue..."
      gets
    else
      computer = "O"
      puts "You chose X's the computer will be O's. Press [enter] to continue..."
      gets
    end
  	
    spaces = initialize_spaces
  	
    draw_board(spaces)
  	
  #The play...............................................................
    if player == "X"
      begin
        player_choice(spaces, player)
        winner = check_win(spaces)
        break if winner || empty_spaces(spaces).empty?
        computer_choice(spaces, computer)
        draw_board(spaces)
        winner = check_win(spaces)
      end until winner || empty_spaces(spaces).empty?
    else
      begin
        computer_choice(spaces, computer)
        winner = check_win(spaces)
        draw_board(spaces)
        break if winner || empty_spaces(spaces).empty?
        player_choice(spaces, player)
        winner = check_win(spaces)
      end until winner || empty_spaces(spaces).empty?
    end
  	
  #Win message...........................................................
    if winner == player
      puts "#{winner}'s won! Cograts, you beat the computer!"
      replay = play_again
    elsif winner == computer
      puts "#{winner}'s won! Sorry, you lost...try again next time."
      replay = play_again
    else
      puts "Cat game! It's a tie. Good game."
      replay = play_again
    end
  
  end until replay != "Y"
end

Game
