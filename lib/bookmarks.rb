require 'pg'
require 'uri'
require_relative './comment'
require_relative 'database_connection'
require_relative 'tag'


class Bookmark
  attr_reader :url, :title, :id

  def initialize(url:, title:, id:)
      @id = id
      @url = url
      @title = title
  end

  def self.all
    result = DatabaseConnection.query("SELECT * FROM bookmarks;")
    result.map do |bookmark|
      Bookmark.new(
        id: bookmark['id'],
        title: bookmark['title'],
        url: bookmark['url']
      )
    end
  end

  def self.create(url:, title:)
    return false unless is_url?(url)
    result = DatabaseConnection.query("INSERT INTO bookmarks(title, url) VALUES ('#{title}', '#{url}') RETURNING id, url, title;")
    Bookmark.new(
      id: result[0]['id'],
      title: result[0]['title'],
      url: result[0]['url']
    )
  end

  def self.delete(id:)
    DatabaseConnection.query("DELETE FROM bookmark_tags WHERE bookmark_id = #{id};")
    DatabaseConnection.query("DELETE FROM comments WHERE bookmark_id = #{id};")
    DatabaseConnection.query("DELETE FROM bookmarks WHERE id = #{id}")
  end

  def self.edit(id:, url:, title:)
    result = DatabaseConnection.query("UPDATE bookmarks SET url = '#{url}', title = '#{title}' WHERE id = '#{id}' RETURNING id, url, title;")
    Bookmark.new(
      id: result[0]['id'],
      title: result[0]['title'],
      url: result[0]['url']
    )
  end

  def self.find(id:)
    result = DatabaseConnection.query("SELECT * FROM bookmarks WHERE id = #{id};")
    Bookmark.new(
      id: result[0]['id'],
      title: result[0]['title'],
      url: result[0]['url']
    )
  end

  def comments(comment_class = Comment)
    comment_class.where(bookmark_id: id)
  end

  def tags(tag_class = Tag)
    tag_class.where(bookmark_id: id)
  end

  def self.where(tag_id:)
    result = DatabaseConnection.query("SELECT id, title, url FROM bookmark_tags INNER JOIN bookmarks ON bookmarks.id = bookmark_tags.bookmark_id WHERE bookmark_tags.tag_id = '#{tag_id}';")
    result.map do |bookmark|
      Bookmark.new(
        id: bookmark['id'],
        title: bookmark['title'],
        url: bookmark['url']
        )
    end
  end

  private

  def self.is_url?(url)
    url =~ /\A#{URI::regexp(['http', 'https'])}\z/
  end
end
