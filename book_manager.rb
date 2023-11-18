require_relative 'book'
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
