#Exercises 1, 2, and 3

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
  
end

steve_car = MyCar.new(2000, "white", "avalon")
puts "My #{steve_car.year} #{steve_car.color} #{steve_car.model.capitalize} is a little scratched up...let's get it painted!"
puts "Off to the body shop..."
steve_car.speed_up(35)
steve_car.speed_up(15)
puts "There's a cop... Oh no, I'm going #{steve_car.current_speed}mph in a 35! I'm speeding!"
steve_car.brake(15)
steve_car.turn_off
puts "What color?"
paint = gets.chomp
steve_car.spray_paint(paint)
puts "My car looks great. A beautiful #{steve_car.color}!"


