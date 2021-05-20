require_relative 'superclass'
require_relative 'books_database'
require_relative 'books'
require_relative 'customers'

class Reviews < SuperbookClass
    attr_reader :id
    attr_accessor :body, :book_id, :customer_id, :rating, :parent_reply_id
    def initialize(hash)
        @id, @body, @book_id, @customer_id, @rating, @parent_reply_id = hash.values_at('id', 'body', 'book_id', 'customer_id', 'rating', 'parent_reply_id')
    end
    require 'byebug'
    def self.find_by_book_id(bookid)
        reviews_data = BooksDatabase.execute(<<-SQL, bookid: bookid)
            SELECT
                *
            FROM
                reviews
            WHERE
                reviews.book_id = :bookid
        SQL
        reviews_data.map { |review_data| Reviews.new(review_data) }
    end

    def self.find_by_customer_id(customer_id)
        reviews_data = BooksDatabase.execute(<<-SQL, customer_id: customer_id)
            SELECT
                *
            FROM
                reviews
            WHERE
                reviews.customer_id = :customer_id
        SQL
        reviews_data.map{ |review_data| Reviews.new(review_data)}
    end

    def author
        Customers.find(customer_id)
    end

    def book_reviewed
        Books.find_by_id(book_id)
    end
        
end