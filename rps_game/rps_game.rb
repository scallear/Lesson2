class Players
  attr_accessor :choice
  attr_reader :name
  
  def initialize(name)
    @name = name
  end
end

class User < Players
  def pick_play
    begin
      puts "Pick your throw: [r] for rock, [p] for paper, or [s] for scissors"
      self.choice = gets.chomp.downcase
    end until Game::CHOICES.keys.include?(self.choice)
  end
end

class Computer < Players
  def pick_play
    self.choice = Game::CHOICES.keys.sample
  end
end

class Game
  CHOICES = { "s" => "SCISSORS", "p" => "PAPER", "r" => "ROCK"}
  
  attr_accessor :user, :computer
  
  @@round_num = 0
  
  def initialize
    @user = User.new('You')
    @computer = Computer.new('Computer')
  end
  
  def intro
    system 'clear'
    puts "Welcome to Rock, Paper, Scissors!"
    puts "Play until you loose. See how many rounds you can last."
    puts "Remember!: Rock > Scissors > Paper > Rock"
    puts "Ready? Press [Enter]."
    gets
  end
  
  def display_choices
    puts "You chose #{CHOICES[user.choice]}..."
    puts "The computer chose #{CHOICES[computer.choice]}..."
  end
  
  def check_win
    if user.choice == computer.choice
      "tie"
    elsif (user.choice == "s" && computer.choice == "p") || 
          (user.choice == "r" && computer.choice == "s") ||
          (user.choice == "p" && computer.choice == "r")
      "win"
    else
      "loose"
    end
  end
  
  def winning_statement
    if check_win == "tie"
      puts "It's a tie you both picked #{CHOICES[user.choice]}"
    elsif check_win == "win"
      puts "#{CHOICES[user.choice]} beats #{CHOICES[computer.choice]}. You win!"
    else
      puts "#{CHOICES[computer.choice]} beats #{CHOICES[user.choice]}. You loose!"
    end
  end
  
  def display_round
    @@round_num += 1
    system 'clear'
    puts "Round #{@@round_num}, Fight!"
  end
  
  def give_up
    begin
      puts "Give up? [y/n]"
      surrender = gets.chomp.downcase
    end until surrender == "y" || surrender == "n"
    surrender
  end
    
  
  def play
    intro
    
    begin
      display_round
      user.pick_play
      computer.pick_play
      display_choices
      check_win
      winning_statement
    end until check_win == "loose" || give_up == "y"
    
    puts check_win == "loose" ? "Tough break, you lasted #{@@round_num - 1} round(s)!" : 
      "After #{@@round_num} round(s), you gave up? Try harder next time!"
    puts "Thanks for playing!"
  end
end

Game.new.play