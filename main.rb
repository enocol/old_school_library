
require_relative 'app'

class Main
  def initialize(app)
    @app = app
  end

  def run
    @app.display_welcome_message

    loop do
      print_options_menu
      option = gets.chomp.to_i
      @app.process_option(option)
      break if @app.exit_option?(option)
    end

    @app.display_goodbye_message
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
end

app = App.new
main = Main.new(app)
main.run
