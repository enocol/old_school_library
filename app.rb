
require_relative 'person'
require_relative 'book'
require_relative 'rental'
require_relative 'student'
require_relative 'teacher'
require 'date'

class App
  def initialize
    @person = {'teachers' => [], 'students' => []}
    @books = []
    @rentals = []
  end


  def run
    puts ''
    puts 'Welcome to the Library App!'
    puts ''
    
    loop do
      puts ''
      print 'Please choose an option by selecting a number: '
      puts ''
      puts "\nOptions:"
      puts '1. List all books'
      puts '2. List all people'
      puts '3. Create a person'
      puts '4. Create a book'
      puts '5. Create a rental'
      puts '6. List rentals for a person with a give id'
      puts '7. Exit'
      

      option = gets.chomp.to_i

      case option
        when 1
        list_all_books
        when 2
        list_all_people
        when 3
        create_person_prompt
        when 4
        create_book_prompt
        when 5
        create_rental_prompt
        when 6
        list_rentals_for_person_prompt
        when 7
        break
        else
        puts 'Invalid option. Please try again.'
        end

    end

    puts 'Exiting the Library App. Goodbye!'
  end

  private

  def create_person_prompt
    print 'Do you want to enter a student(1) or a teacher(2)): '
    options = gets.chomp.to_i
    if options == 1
      puts ''
      print 'Enter age: '
      age = gets.chomp.to_i
      print 'enter name: '
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
      student = Student.new(age, name, parent_permission, classroom)

      new_student =
       {'age' => student.age,
         'type' => 'student',
        'name' => student.name,
        'id' => student.id,
        'parent_permission' => student.parent_permission,
        'classroon' => student.classroom
        }

      @person['students'] << new_student
      puts ''
      puts new_student
      puts 'student info saved'
      puts ''

    else
        puts ''
        print 'Enter teacher age:  '
        age = gets.chomp.to_i
        print 'enter name: '
        name = gets.chomp
        print puts 'Does Teacher have parent_permission? (1 = yes, 2 = no):  '
        parent_permission = gets.chomp.to_i

      if parent_permission == 1
        parent_permission = true
      else 
        parent_permission = false
      end

      print 'Enter Specialisation:  '
      specialization = gets.chomp
      teacher = Teacher.new(age, name, parent_permission, specialization)
      new_teacher =
       {'age' => teacher.age,
         'type' => 'teacher',
        'name' => teacher.name,
        'id' => teacher.id,
        'parent_permission' => teacher.parent_permission,
        'specialization' => teacher.specialization
       }
      @person['teachers'] << new_teacher
      puts ''
      puts 'Teacher info Saved'
      puts ''
    end
 end

  def create_book_prompt
    print 'Enter title: '
    title = gets.chomp
    print 'Enter author: '
    author = gets.chomp
    new_book = Book.new(title, author)
    book_hash = {
        'title' => new_book.title,
        'author' => new_book.author,
    }
    @books << new_book
    puts ''
    puts 'Book saved Successfylly'
    puts ''
  end

  def create_rental_prompt
    if @books.length == 0
      puts ''
      puts 'There are no book'
      puts ''
    else
      puts 'Select a book by its number'
      @books.each_with_index { |book, index| puts "#{index})Title: #{book.title} by  Author: #{book.author}" }
      book_index = gets.chop.to_i
      people = @person['teachers'] + @person['students']
      labels = people.map { |person| person['type'] == 'teacher' ? '[teacher]' : '[student]' }
      puts 'Select a person by its number'

      people.each_with_index do |person, index|
        label = labels[index]
        puts "#{index})#{label} Name: #{person['name']}, ID: #{person['id']}, Age: #{person['age']}"
      end

      person_index = gets.chop.to_i
      print 'Enter the date (MM/DD/YYYY): '
      date_string = gets.chomp

      begin
       date = Date.strptime(date_string, '%m/%d/%Y')
       rescue ArgumentError
       puts 'Invalid date format. Please enter the date in MM/DD/YYYY format.'
      end
      
      date = "#{date}"
      person_data = people[person_index]
      book_data = @books[book_index]
      new_rental = Rental.new(date, person_data, book_data)
      @rentals << new_rental
      puts ''
      puts 'Rental created successfully'
      puts ''
    end    
  end

  def list_rentals_for_person_prompt
    print 'Enter person ID: '
    person_id = gets.chomp.to_i
    @rentals.each do
     |rents|
     puts "date #{rents.date}, book: #{rents.book.title},by Author: #{rents.book.author}" if rents.person['id'] == person_id
    end
   end

   def list_all_books
        if @books.length == 0
          puts 'There are no book'
          puts ''
        else
          @books.each_with_index { |book, index| puts "#{index})Title: #{book.title} by  Author: #{book.author}" }
          puts ''
        end
   end

   def list_all_people
    @person['teachers'].each {|teacher| puts "[teacher] Name: #{teacher['name']}, ID: #{teacher['id']}, Age: #{teacher['age']}"}
    @person['students'].each {|student| puts "[student] Name: #{student['name']}, ID: #{student['id']}, Age: #{student['age']}"}
   end
end


