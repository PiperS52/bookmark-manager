require 'pg'

class Bookmarks 

    def self.all
         if ENV['RACK_ENV'] == 'test' ? connection = PG.connect(dbname: 'bookmark_manager_test') : connection = PG.connect(dbname: 'bookmark_manager')
         end
        result = connection.exec("SELECT * FROM bookmarks;")
        result.map { |bookmark| bookmark['url'] }
    end
end 