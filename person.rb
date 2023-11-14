class Person
  attr_reader :id,
  

  def initialize(id, age, name = 'Unknown', parent_permission = true)
    @id = id
    @name = name
    @age = age
    @parent_permission = parent_permission
  end

  def name(name)
    @name = name
  end

  def age(age)
    @age = age
  end

  def can_use_services?
    of_age? || @parent_permission
  end

  private

  def of_age?
    @age >= 18
  end
end


student = Person.new(1, 34, 'enoh', true)

p student.of_age?(16)