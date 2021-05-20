
require_relative 'superclass'
require_relative 'customers'
require_relative 'books_database'
require_relative 'reviews'
require_relative 'book_purchases'

class Books < SuperbookClass
    attr_reader :id
    attr_accessor :title, :blurb
    def initialize(hash)
        @id, @title, @blurb = hash.values_at('id', 'title', 'blurb')
    end

    def self.find_by_title_and_blurb(title, blurb)
        attrs = { title: title, blurb: blurb }
        book_data = BooksDatabase.get_first_row(<<-SQL, attrs)
            SELECT
                *
            FROM
                books
            WHERE
                books.title = :title AND books.blurb = :blurb
            SQL
        book_data.nil? ? nil: Books.new(book_data)
    end

    def self.most_bought(n)
        BookPurchases.most_bought_book(n)
    end

    def book_reviews
        Reviews.find_by_book_id(id)
    end

    def readers
        Customers.find_by_book_id(id)
    end

    def customers
        BookPurchases.purchases_for_book_id(id)
    end


    def self.find_by_id(book_id)
        books_data = BooksDatabase.execute(<<-SQL, book_id: book_id)
            SELECT
                *
            FROM
                books
            WHERE
                books.id = :book_id
        SQL
        books_data.map { |book_data| Books.new(book_data) }
    end
end