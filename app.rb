require_relative 'person'
require_relative 'book'
require_relative 'rental'
require_relative 'student'
require_relative 'teacher'
require 'date'

class PersonManager
  def initialize
    @people = {'teachers' => [], 'students' => []}
  end

  def create_student(age, name, parent_permission, classroom)
    student = Student.new(age, name, parent_permission, classroom)
    @people['students'] << student_info(student)
  end

  def create_teacher(age, name, parent_permission, specialization)
    teacher = Teacher.new(age, name, parent_permission, specialization)
    @people['teachers'] << teacher_info(teacher)
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

 # def teacher_info_str(teacher)
  #  "[teacher] Name: #{teacher['name']}, ID: #{teacher['id']}, Age: #{teacher['age']}"
  #end

  #def student_info_str(student)
    #"[student] Name: #{student['name']}, ID: #{student['id']}, Age: #{student['age']}"
 # end


   def get_person(index)
    people = @people['teachers'] + @people['students']
    people[index]
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

class BookManager
  def initialize
    @books = []
  end

  def create_book(title, author)
    new_book = Book.new(title, author)
    @books << new_book
    puts ''
    puts 'Book saved successfully'
  end

  def list_all_books
    if @books.empty?
      puts 'There are no books'
    else
      @books.each_with_index { |book, index| puts "#{index}) Title: #{book.title} by Author: #{book.author}" }
    end
  end

   def get_book(index)
    @books[index]
  end

end

class RentalManager
  def initialize
    @rentals = []
  end

  def create_rental(date, person, book)
    new_rental = Rental.new(date, person, book)
    @rentals << new_rental
    puts ''
    puts 'Rental created successfully'
  end

  def list_rentals_for_person(person_id)
    @rentals.each do |rental|
      puts "Date: #{rental.date}, " \
     "Book: #{rental.book.title} by " \
     "Author: #{rental.book.author}" if rental.person['id'] == person_id
    end
  end
end

class App
  def initialize
    @person_manager = PersonManager.new
    @book_manager = BookManager.new
    @rental_manager = RentalManager.new
  end

  def run
  display_welcome_message

  loop do
    print_options_menu
    option = gets.chomp.to_i
    process_option(option)
    break if exit_option?(option)
  end

  display_goodbye_message
  end

  private

  def display_welcome_message
    puts ''
    puts 'Welcome to the Library App!'
  end

  def print_options_menu
    puts ''
    print 'Please choose an option by selecting a number: '
    puts "\nOptions:"
    puts '1. List all books'
    puts '2. List all people'
    puts '3. Create a person'
    puts '4. Create a book'
    puts '5. Create a rental'
    puts '6. List rentals for a person with a given id'
    puts '7. Exit'
  end

  def process_option(option)
    case option
    when 1 then @book_manager.list_all_books
    when 2 then @person_manager.list_all_people
    when 3 then create_person_prompt
    when 4 then create_book_prompt
    when 5 then create_rental_prompt
    when 6 then list_rentals_for_person_prompt
    when 7 then exit
    else puts 'Invalid option. Please try again.'
    end
  end

  def exit_option?(option)
    option == 7
  end

  def display_goodbye_message
    puts 'Exiting the Library App. Goodbye!'
  end

  private

  def create_person_prompt
    print 'Do you want to enter a student(1) or a teacher(2)): '
    options = gets.chomp.to_i
    if options == 1
      create_student_prompt
    else
      create_teacher_prompt
    end
  end

  def create_student_prompt
    print 'Enter age: '
    age = gets.chomp.to_i
    print 'Enter name: '
    name = gets.chomp
    print 'Does Student have parent_permission? (1 = yes, 2 = no):  '
    parent_permission = gets.chomp.to_i

    if parent_permission == 1
      parent_permission = true
    else 
      parent_permission = false
    end

    print 'Enter classroom: '
    classroom = gets.chomp

    @person_manager.create_student(age, name, parent_permission, classroom)
    puts ''
    puts 'Student saved successfully'
  end

  def create_teacher_prompt
    print 'Enter teacher age:  '
    age = gets.chomp.to_i
    print 'Enter name: '
    name = gets.chomp
    puts 'Does Teacher have parent_permission? (1 = yes, 2 = no):  '
    parent_permission = gets.chomp.to_i

    if parent_permission == 1
      parent_permission = true
    else 
      parent_permission = false
    end

    print 'Enter Specialisation:  '
    specialization = gets.chomp

    @person_manager.create_teacher(age, name, parent_permission, specialization)
    puts ''
    puts 'Teacher saved Successfully'
  end

  def create_book_prompt
    print 'Enter title: '
    title = gets.chomp
    print 'Enter author: '
    author = gets.chomp
    @book_manager.create_book(title, author)
    puts ''
    puts 'Book saved successfully'
  end

  def create_rental_prompt
    puts 'Select a book by its number: '
    @book_manager.list_all_books
    book_index = gets.chomp.to_i
    puts 'Select a person by its number: '
    @person_manager.list_all_people
    person_index = gets.chomp.to_i

    print 'Enter the date (MM/DD/YYYY): '
    date_string = gets.chomp

    begin
      date = Date.strptime(date_string, '%m/%d/%Y')
    rescue ArgumentError
      puts 'Invalid date format. Please enter the date in MM/DD/YYYY format.'
      return
    end

    @rental_manager.create_rental(date, @person_manager.get_person(person_index), @book_manager.get_book(book_index))
  end

  def list_rentals_for_person_prompt
    print 'Enter person ID: '
    person_id = gets.chomp.to_i
    @rental_manager.list_rentals_for_person(person_id)
  end
end





