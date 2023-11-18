require_relative 'app'

def main
  app = App.new
  app.run
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
end
main
