require_relative 'books_database'
require_relative 'books'
require_relative 'reviews'
require_relative 'customers'

require 'byebug'
class BookPurchases < BooksDatabase
    def self.purchases_for_customer_id(customer_id)
        
        book_data = BooksDatabase.execute(<<-SQL, customer_id: customer_id)
            SELECT
                *
            FROM 
                books
            JOIN
                book_purchases
            ON
                books.id = book_purchases.book_id
            WHERE
                book_purchases.customer_id = :customer_id
        SQL

        book_data.map { |book| Books.new(book)}
    end

    def self.purchases_for_book_id(bookid)
        
        book_data = BooksDatabase.execute(<<-SQL, bookid: bookid)
            SELECT
                *
            FROM 
                customers
            JOIN
                book_purchases
            ON
                customers.book_purchased = book_purchases.book_id
            WHERE
                book_purchases.book_id = :bookid
        SQL

        book_data.map { |book_inf| Customers.new(book_inf)}
    end

    
    def self.most_bought_book(n)
        
        book_data = BooksDatabase.execute(<<-SQL, limit: n)
            SELECT
               *
            FROM
                books
            JOIN
                book_purchases
            ON 
                books.id = book_purchases.book_id
            GROUP BY
                books.title
            ORDER BY
                COUNT(book_purchases.book_id) DESC
            LIMIT
                :limit
        SQL


        book_data.map { |book| Books.new(book)}
    end
end