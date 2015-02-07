class Animal
    attr_accessor :name
  
  def initialize(n)
    @name = n
  end
  
  def eat
    "#{name} is eating."
  end
end

class Dog < Animal
  def fetch
    "asdf"
end

class Cat

end

teddy = Dog.new("Teddy")
puts teddy.name

kitty = Cat.new("kitty")
puts kitty.name