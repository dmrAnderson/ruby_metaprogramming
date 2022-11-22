module AkaDraper
  class Base < SimpleDelegator
    def self.decorate(obj)
      new(obj)
    end
  end
end

module AkaDraper
  def decorate
    "#{self.class.name}Decorator".then do |decorator_class|
      raise "Implement '#{decorator_class}' class" unless Object.const_defined?(decorator_class.to_s)
      Object.const_get(decorator_class).decorate(self)
    end
  end
end

class Object
  include AkaDraper
end

class Animal
  attr_reader :name

  def initialize(name)
    @name = name
  end
end


class Dog < Animal; end
class Cat < Animal; end

class DogDecorator < AkaDraper::Base
  def dc_name
    'DC dog_name'
  end
end

dog = Dog.new('dog_name')
dc_dog = dog.decorate

dog.name                   # => 'dog_name'
dc_dog.dc_name             # => 'DC dog_name'

cat = Cat.new('cat_name')  # => 'DC cat_name'
dc_cat = cat.decorate      # => RuntimeError (Implement 'CatDecorator' class)
