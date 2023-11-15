require_relative 'person'

class Teacher < Person
  attr_accessor :specialization

  def initialize(age, name: 'Unknown', parent_permission: false, specialization: nil)
    super(age, name: name, parent_permission: false)
    @specialization = specialization
  end
end
