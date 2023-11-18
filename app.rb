require 'date'
require_relative 'person_manager'
require_relative 'book_manager'
require_relative 'rental_manager'

class App
  def initialize
    @person_manager = PersonManager.new
    @book_manager = BookManager.new
    @rental_manager = RentalManager.new
  end

  def display_welcome_message
    puts ''
    puts 'Welcome to the Library App!'
  end

  def process_option(option)
    case option
    when 1 then list_all_books
    when 2 then list_all_people
    when 3 then create_person_prompt
    when 4 then create_book_prompt
    when 5 then create_rental_prompt
    when 6 then list_rentals_for_person_prompt
    when 7 then exit_app
    else invalid_option
    end
  end

  def list_all_books
    @book_manager.list_all_books
  end

  def list_all_people
    @person_manager.list_all_people
  end

  def exit_app
    puts 'Exiting the Library App. Goodbye!'
    exit
  end

  def invalid_option
    puts 'Invalid option. Please try again.'
  end

  def exit_option?(option)
    option == 7
  end

  def display_goodbye_message
    puts 'Exiting the Library App. Goodbye!'
  end

  def create_person_prompt
    print 'Do you want to enter a student(1) or a teacher(2)): '
    option = gets.chomp.to_i
    if option == 1
      create_person('student')
    elsif option == 2
      create_person('teacher')
    else
      puts 'Invalid option. Please try again.'
    end
  end

  def create_person(person_type)
    print "Enter #{person_type} age: "
    age = gets.chomp.to_i
    print 'Enter name: '
    name = gets.chomp
    print "Does #{person_type} have parent_permission? (1 = yes, 2 = no): "
    parent_permission = gets.chomp.to_i
    parent_permission = parent_permission == 1

    extra_info = person_type == 'student' ? 'classroom' : 'specialization'
    print "Enter #{extra_info}: "
    extra_value = gets.chomp

    if person_type == 'student'
      @person_manager.create_student(age, name, parent_permission, extra_value)
      puts 'Student saved successfully'
    elsif person_type == 'teacher'
      @person_manager.create_teacher(age, name, parent_permission, extra_value)
      puts 'Teacher saved successfully'
    end
  end

  def create_book_prompt
    print 'Enter title: '
    title = gets.chomp
    print 'Enter author: '
    author = gets.chomp
    @book_manager.create_book(title, author)
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
    puts 'Rental created successfully'
  end

  def list_rentals_for_person_prompt
    print 'Enter person ID: '
    person_id = gets.chomp.to_i
    @rental_manager.list_rentals_for_person(person_id)
  end
end
