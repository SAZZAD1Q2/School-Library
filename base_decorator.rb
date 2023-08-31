require_relative 'nameable'

class BaseDecorator < Nameable
  def initialize(nameable)
    super()
    @nameable = nameable
  end

  def correct_name
    @nameable.correct_name
  end
end

# Create an instance of the Decorator class
nameable_instance = Nameable.new # Assume Nameable class exists
decorator_instance = Decorator.new(nameable_instance)

# Calling the method on the decorator
decorator_instance.correct_name
