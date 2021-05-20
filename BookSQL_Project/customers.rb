require_relative 'superclass'
require_relative 'books_database'
require_relative 'books'

class Customers < SuperbookClass
    attr_reader :id
    attr_accessor :email, :first_name, :area, :book_purchased
    def initialize(hash)
        
        @id, @email, @first_name, @area, @book_purchased = hash.values_at('id', 'email', 'first_name', 'area', 'book_purchased')
    end

    def self.find_by_book_id(book_purchased)
        customers_data = BooksDatabase.execute(<<-SQL, book_purchased: book_purchased)
            SELECT
                *
            FROM
                customers
            WHERE 
                customers.book_purchased = :book_purchased
        SQL

        customers_data.map { |customer_data| Customers.new(customer_data) }
    end

    def self.find(id)
        customers_data = BooksDatabase.get_first_row(<<-SQL, id: id)
            SELECT
                *
            FROM
                customers
            WHERE
                customers.id = :id
        SQL
        Customers.new(customers_data)
    end

    def purchased_book
        Books.find_by_id(book_purchased)
    end

    def books_bought
        BookPurchases.purchases_for_customer_id(id)
    end

    def reviews_written
        Reviews.find_by_customer_id(id)
    end
end