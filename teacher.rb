require_relative 'person'

class Teacher < Person
  attr_accessor :specialization, :parent_permission

  def initialize(age, name, parent_permission, specialization)
    super(age, name:, parent_permission:)
    @specialization = specialization
  end
end
