#Exercises 1-6
module Towable
  def can_tow?(pounds)
    pounds < 2000 ? true : false
  end
end

class Vehicle
  @@vehicles = 0
  
  attr_accessor :color, :current_speed
  attr_reader :year, :model
  
  def initialize(year, color, model)
    @year = year
    @color = color
    @model = model
    @current_speed = 0
    @@vehicles +=1
  end
  
  def self.vehicles
    puts "You have #{vehicles}vehicles."
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
  
  def age
    "Your #{model} is #{years_old} years old."  
  end
  
  private
  
  def years_old
    Time.now.year - self.year
  end
end

class MyTruck < Vehicle
  include Towable
  
  NUMBER_OF_DOORS = 2
  
  def to_s
    "My truck is a #{self.color}, #{self.model}, #{self.year}!"
  end
end

class MyCar < Vehicle
  NUMBER_OF_DOORS = 4
  
  def to_s
    "My car is a #{self.color}, #{self.model}, #{self.year}!"
  end
end

lumina = MyCar.new(1997, 'white', 'chevy lumina')
lumina.speed_up(20)
lumina.current_speed
lumina.speed_up(20)
lumina.current_speed
lumina.brake(20)
lumina.current_speed
lumina.brake(20)
lumina.current_speed
lumina.turn_off
MyCar.gas_mileage(13, 351)
lumina.spray_paint("red")
puts lumina
puts lumina.age

puts "Ancestry for Vehicles: #{Vehicle.ancestors}"
puts "\nAncestry for MyCar: #{MyCar.ancestors}"
puts "\nAncestry for MyTruck: #{MyTruck.ancestors}"

#Exercise 7

class Student
  def initialize(name, grade)
    @name = name
    @grade = grade
  end
  
  def better_grade_than?(name)
    self.grade < name.grade ? true: false
  end
  
  protected
  
  def grade
    @grade
  end
end

joe = Student.new("Joe", "C")
steve = Student.new("Steve", "B")

puts "Well doen" if joe.better_grade_than?(steve)

#8) the hi mehtod is private; if you need access to this method you would need to move it to a public section of the class.