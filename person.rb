class Person
  attr_accessor :name, :age
  attr_reader :id, :parent_permission

  def initialize(age, name = 'Unknown', parent_permission: true)
    @id = generate_id
    @name = name
    @age = age
    @parent_permission = parent_permission
  end

  def can_use_services?
    of_age? || @parent_permission
  end

  private

  def generate_id
    Random.rand(1..10_000)
  end

  def of_age?
    @age >= 18
  end
end
