require_relative 'person'

class Teacher < Person

  attr_accessor :specialization
  def initialize(id, age, name: 'Unknown', specialization, parent_permission: parent_permission)
    super(id, age, name: name, parent_permission)
    @specialization = specialization
  end

  def can_use_services?
    true
  end
