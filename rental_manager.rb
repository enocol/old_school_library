require_relative 'book'
require_relative 'rental'
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
      next unless rental.person['id'] == person_id

      display_rental_info(rental)
    end
  end

  private

  def display_rental_info(rental)
    puts "Date: #{rental.date}, " \
         "Book: #{rental.book.title} by " \
         "Author: #{rental.book.author}"
  end
end