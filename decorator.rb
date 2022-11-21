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

class Dog
  attr_reader :name

  def initialize(name)
    @name = name
  end
end

class DogDecorator < AkaDraper::Base
  def dc_name
    'QQQ'
  end
end

Dog.new('aaa').decorate
