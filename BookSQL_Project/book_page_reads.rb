require_relative 'books_database'
require_relative 'books'
require_relative 'reviews'
require_relative 'customers'

class PageReads < BooksDatabase
    def self.reads_for_book_id(book_id)
        book_data = BooksDatabase.execute(<<-SQL, book_id: book_id)
            SELECT
                page_reads
            FROM 
                book_page_reads
            WHERE
                book_page_reads.book_id = :book_id
        SQL

        book_data
    end

    def self.avg_page_reads
        book_data = BooksDatabase.execute(<<-SQL)
            SELECT
                page_reads
            FROM 
                book_page_reads
        SQL
        sum = 0
        book_data.each {|page_hash| sum+=page_hash["page_reads"]}
        sum/book_data.length
    end
end