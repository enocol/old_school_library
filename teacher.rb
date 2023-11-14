require_relative 'person'

class Teacher < Person

  attr_accessor :specialization
  def initialize(id, age, specialization, name: 'Unknown', parent_permission: false)
    super(id, age, name: name, parent_permission: parent_permission)
    @specialization = specialization
  end

  def can_use_services?
    true
  end
end