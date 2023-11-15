require_relative 'person'

class Student < Person
  attr_reader :classroom

  def initialize(age, name: 'Unknown', parent_permission: true, classroom: nil)
    super(age, name:, parent_permission:)
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
