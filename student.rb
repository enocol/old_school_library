require_relative 'person'

class Student < Person
  attr_accessor :classroom

  def initialize(age, name: 'Unknown', parent_permission: true, classroom: nil)
    super(age, name: 'Unknown', parent_permission: true)
    @classroom = classroom
    add_to_classroom_students if classroom
  end

  def play_hooky
    '¯\\(ツ)/¯'
  end

  private

  def add_to_classroom_students
    classroom.students << self
  end
end
