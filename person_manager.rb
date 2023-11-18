require_relative 'teacher'
require_relative 'student'
class PersonManager
  def initialize
    @people = { 'teachers' => [], 'students' => [] }
  end

  def create_student(age, name, parent_permission, classroom)
    student = Student.new(age, name, parent_permission, classroom)
    @people['students'] << student_info(student)
  end

  def create_teacher(age, name, parent_permission, specialization)
    teacher = Teacher.new(age, name, parent_permission, specialization)
    @people['teachers'] << teacher_info(teacher)
  end

  def get_person(index)
    people = @people['teachers'] + @people['students']
    people[index]
  end

  def list_all_people
    teachers = @people['teachers']
    students = @people['students']

    teachers.each_with_index do |teacher, index|
      puts "#{index}) #{teacher_info_str(teacher)}"
    end

    students.each_with_index do |student, index|
      puts "#{teachers.length + index}) #{student_info_str(student)}"
    end

    puts ''
  end

  private

  def student_info(student)
    {
      'age' => student.age,
      'type' => 'student',
      'name' => student.name,
      'id' => student.id,
      'parent_permission' => student.parent_permission,
      'classroom' => student.classroom
    }
  end

  def teacher_info(teacher)
    {
      'age' => teacher.age,
      'type' => 'teacher',
      'name' => teacher.name,
      'id' => teacher.id,
      'parent_permission' => teacher.parent_permission,
      'specialization' => teacher.specialization
    }
  end

  def student_info_str(student)
    "[student] Name: #{student['name']}, ID: #{student['id']}, Age: #{student['age']}"
  end

  def teacher_info_str(teacher)
    "[teacher] Name: #{teacher['name']}, ID: #{teacher['id']}, Age: #{teacher['age']}"
  end
end
