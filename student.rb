require_relative 'person'

class Student < Person
  attr_reader :classroom, :parent_permission

  def initialize(age, name, parent_permission, classroom)
    super(age, name: name, parent_permission: parent_permission)
    @classroom = classroom
    
  end

  def play_hooky
    '¯\\(ツ)/¯'
  end
end
