class Player
  attr_accessor :hand
  attr_reader :name
  
  def initialize(name)
    @name = name
    @hand = []
  end
  
  def hand_value
    total = 0

    hand.each do |card|
      total += card.value
    end
    
    hand.select {|card| card.face == "A"}.count.times do
      total -= 10 if total > GameEngine::BLACKJACK
    end
      
    total
  end
  
  def is_busted?
    hand_value > GameEngine::BLACKJACK
  end
end

class House < Player
  def initialize
    super("Dealer")
  end
  
  def show_flop
    puts "=> #{name}: #{hand[1]} showing"
  end
end

class Challenger < Player
  attr_accessor :money, :bet
  
  def initialize(name)
    super(name)
    @money = 20
    @bet = 0
  end
  
  def show_hand
    cards = ""
    hand.each_index do |card|
      cards += "#{hand[card]} " 
    end
    puts "=> #{name}: #{cards} Total: #{hand_value}"
  end
  
  def show_flop
    show_hand
  end
end

class Card
  attr_reader :face, :suit
  
  def initialize(face, suit)
    @face = face
    @suit = suit
  end
  
  def to_s
    "#{face}#{suit}"
  end
  
  def value
    if ["J", "Q", "K"].include?(face)
      10
    elsif face == "A"
      11
    else
      face.to_i
    end
  end
end

class Deck
  attr_accessor :cards
  
  SUIT = ["♥", "♦", "♣", "♠" ]
  FACE = ["2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K", "A"]
  
  def initialize
    @cards = []
    SUIT.each do |suit|
      FACE.each do |face|
        @cards << Card.new(face, suit)
      end
    end
    cards.shuffle!
  end
  
  def draw
    cards.pop
  end
end

class GameEngine
  attr_accessor :game_deck, :player, :dealer
  
  BLACKJACK = 21
  HOUSE_HITS_UNDER = 17
  
  def initialize
    @game_deck = Deck.new
    intro
    create_players
  end
  
  def create_players
    @dealer = House.new
    
    puts "What's your name?"
    name = gets.chomp.capitalize
    @player = Challenger.new(name)
  end

  def intro
    puts "Welcome to blackjack!" 
    puts "You've been given $20 to start, see how long you last."
    puts "If you break the house by making more than $50, you win!"
  end
  
  def place_bet
    puts "#{player.name}, you have $#{player.money}, place your bet!"
    player.bet = gets.chomp.to_i
    until player.bet > 0 && player.bet <= player.money
      puts "You must bet something and cannot bet more money than you have!"
      puts "You have $#{player.money}, place your bet!"
      player.bet = gets.chomp.to_i
    end
    player.money -= player.bet
  end
  
  def deal
    system 'clear'
    puts "Let's deal... [press enter]"
    gets
    player.hand << game_deck.draw
    dealer.hand << game_deck.draw
    player.hand << game_deck.draw
    dealer.hand << game_deck.draw
  end
  
  def flop
    player.show_flop
    dealer.show_flop
  end
  
  def blackjack?(house_or_challenger)
    if house_or_challenger.hand_value == BLACKJACK
      if house_or_challenger == player
        puts "Congrats, #{house_or_challenger.name}. You got blackjack!"
        payout
      elsif house_or_challenger == dealer
        puts "Awwh rats, the #{house_or_challenger.name} got blackjack. "
        payout
      end
    end
  end
  
  def busted?(house_or_challenger)
    if house_or_challenger.hand_value > BLACKJACK
      if house_or_challenger == player
        puts "#{house_or_challenger.name} busted, try again!"
        payout
      elsif house_or_challenger == dealer
        puts "#{house_or_challenger.name} busted, #{player.name} wins."
        payout
      end
    end  
  end
  
  def player_turn
    blackjack?(player)
    until player.is_busted?
      puts "Hit/Stay?"
      response = gets.chomp.downcase
      if !['hit', 'stay'].include?(response)
        puts "Error: Type [hit] or [stay]."
        next
      end
      if response == "stay"
        break 
      else
        player.hand << game_deck.draw
        player.show_hand
      end
      blackjack?(player)
      busted?(player)
    end
  end
  
  def dealer_turn
    blackjack?(dealer)
    until dealer.is_busted? || dealer.hand_value > 16
      dealer.hand << game_deck.draw
      blackjack?(dealer)
      busted?(dealer)
    end
  end
  
  def winner
    if player.hand_value > dealer.hand_value
      puts "#{player.name} beat the #{dealer.name} #{player.hand_value} to #{dealer.hand_value}."
      puts "Way to go, #{player.name}."
    elsif dealer.hand_value > player.hand_value
      puts "The #{dealer.name} beat #{player.name} #{dealer.hand_value} to #{player.hand_value}."
    else
      puts "#{dealer.name} and #{player.name} have #{dealer.hand_value}. It's a tie!"
    end
    payout
  end
  
  def payout
    case
    when player.hand_value == BLACKJACK
      player.money += (player.bet * 3)
    when player.hand_value == dealer.hand_value
      player.money += player.bet
    when player.hand_value > BLACKJACK
      player.money
    when dealer.hand_value > BLACKJACK
      player.money += (player.bet * 2)
    when player.hand_value < dealer.hand_value
      player.money
    when player.hand_value > dealer.hand_value
      player.money += (player.bet * 2)
    end
    puts "=> #{player.name} has $#{player.money}."
    continue?
  end
  
  def continue?
    if player.money >= 50
      puts "#{player.name} beat the house! Congrats!"
      exit
    elsif player.money < 5
      puts "#{player.name}'s broke. Better luck next time..."
      exit
    else
      begin  
        puts "Keep going? (y/n)"
        response = gets.chomp.downcase
      end until ["y", "n"].include?(response)
      if response  == "y"
        system 'clear'
        puts "Next round..."
        game_deck = Deck.new
        player.hand = []
        dealer.hand = []
        play
      else
        puts "#{player.name} quit?!?! Try harder next time."
        exit
      end
    end
  end
  
  def play
    place_bet
    deal
    flop
    player_turn
    dealer_turn
    winner
  end
end

GameEngine.new.play
