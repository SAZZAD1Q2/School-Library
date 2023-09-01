# require './person'

# class Student < Person
#   attr_reader :classroom

#   def initialize(age, name = 'Unknown', parent_permission: true, classroom)
#     super(age, name, parent_permission: parent_permission)
#     @classroom = classroom
#   end

#   def play_hooky
#     '¯(ツ)/¯'
#   end

#   def classroom=(classroom)
#     @classroom = classroom
#     classroom.students.push(self) unless classroom.students.include?(self)
#   end
# end
require_relative 'person'
class Student < Person
  def initialize(age, classroom:, name: 'Unknown')
    super(age, name, parent_permission: parent_permission)
    @classroom = classroom
  end

  def classroom=(classroom)
    @classroom = classroom
    classroom.students.push(self) unless classroom.students.include?(self)
  end

  def play_hooky
    '¯\(ツ)/¯'
  end
end