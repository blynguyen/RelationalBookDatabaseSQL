require 'active_support/inflector'
require_relative 'books_database.rb'

class SuperbookClass 
    def self.table
        self.to_s.tableize
    end

    def self.id_search(id)
        data = BooksDatabase.get_first_row(<<-SQL, id: id)
            SELECT
                *
            FROM
                #{table}
            WHERE
                id = :id
            SQL
            return self.new(data) if !data.nil?
            nil
    end
end


        
        