require 'pg'

class Bookmarks

    attr_reader :url, :title, :id

    def initialize(url:, title:, id:)
        @id = id
        @url = url
        @title = title
    end

    def self.all
      if ENV['ENVIRONMENT'] == 'test'
        connection = PG.connect(dbname: 'bookmark_manager_test')
      else
        connection = PG.connect(dbname: 'bookmark_manager')
      end
      result = connection.exec("SELECT * FROM bookmarks")
      result.map do |bookmark|
        Bookmarks.new(id: bookmark['id'], title: bookmark['title'], url: bookmark['url'])
      end
    end

    def self.create(url:, title:)
      if ENV['ENVIRONMENT'] == 'test'
          connection = PG.connect(dbname: 'bookmark_manager_test')
      else
          connection = PG.connect(dbname: 'bookmark_manager')
      end
      result = connection.exec("INSERT INTO bookmarks(title, url) VALUES ('#{title}', '#{url}') RETURNING id, url, title")
    end


end
