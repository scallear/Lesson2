#1) & 2) class below 3) the attr_reader only creates a getter method that reads the var, you'd have to switch it to accessor or writer

class MyCar
  attr_accessor :color, :current_speed
  attr_reader :year, :model
  
  def initialize(year, color, model)
    @year = year
    @color = color
    @model = model
    @current_speed = 0
  end
  
  def speed_up(how_much)
    self.current_speed += how_much
    puts "You increased your speed by #{how_much}mph. You are now going #{current_speed}mph."
  end
  
  def brake(how_much)
    self.current_speed -= how_much
    puts "You put on the breaks. Your speed decreased by #{how_much}mph. You are now going #{current_speed}mph."
  end
  
  def turn_off
    self.current_speed = 0
    puts "We've arrived and turned off the car."
  end

  def spray_paint(new_color)
    self.color = new_color
  end
  
  def self.gas_mileage(gallons, miles)
    puts "#{miles / gallons} miles per gallon"
  end
  
  def to_s
    "My car is a #{self.color}, #{self.model}, #{self.year}!"
  end
  
end

car = MyCar.new(2013, "Orange", "Hyundai")

puts car

MyCar.gas_mileage(15, 350)
