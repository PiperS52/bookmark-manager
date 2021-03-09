require 'database_helpers'
require './lib/bookmarks'
require 'tag'
require 'bookmark_tag'

describe Bookmark do
  let(:comment_class_double) { double :comment_class }
  let(:tag_class_double) { double :tag_class }

  describe '.all' do
    it 'returns all bookmarks' do
      bookmark = Bookmark.create(url: 'http://www.testbookmark.com', title: 'Test Bookmark')
      Bookmark.create(url: 'http://www.makersacademy.com', title: 'Makers Academy')
      Bookmark.create(url: 'http://www.google.com', title: 'Google')

      bookmarks = Bookmark.all

      expect(bookmarks.length).to eq(3)
      expect(bookmarks.first).to be_a(Bookmark)
      expect(bookmarks.first.id).to eq(bookmark.id)
      expect(bookmarks.first.title).to eq('Test Bookmark')
      expect(bookmarks.first.url).to eq('http://www.testbookmark.com')

    end
  end

  describe '.create' do
    it 'creates a new bookmark' do
      bookmark = Bookmark.create(url: 'http://www.testbookmark.com', title: 'Test Bookmark')
      persisted_data = persisted_data(table: 'bookmarks', id: bookmark.id)
      Bookmark.create(url: 'http://www.destroyallsoftware.com', title: 'Destroy All Software')

      expect(bookmark).to be_a Bookmark
      expect(bookmark.id).to eq persisted_data.first['id']
      expect(bookmark.title).to eq 'Test Bookmark'
      expect(bookmark.url).to eq 'http://www.testbookmark.com'
    end

    it 'does not create a new bookmark if the URL is not valid' do
      Bookmark.create(url: "not a real bookmark", title: "not a real bookmark")
      expect(Bookmark.all).to be_empty
    end
  end

  describe '.delete' do
    it 'deletes a bookmark' do
      bookmark = Bookmark.create(url: 'http://www.testbookmark.com', title: 'Test Bookmark')
      # persisted_data = persisted_data(id: bookmark.id)
      Bookmark.delete(id: bookmark.id)

      expect(Bookmark.all.length).to eq(0)
    end
  end

  describe '.edit' do
    it 'edits a bookmark' do
      bookmark = Bookmark.create(url: 'http://www.testbookmark.com', title: 'Test Bookmark')
      updated_bookmark = Bookmark.edit(id: bookmark.id, url: 'http://twitter.com', title: 'Twitter')

      expect(updated_bookmark).to be_a Bookmark
      expect(updated_bookmark.url).to eq('http://twitter.com')
      expect(updated_bookmark.id).to eq bookmark.id
      expect(updated_bookmark.title).to eq('Twitter')
    end
  end

  describe '.find' do
    it 'finds a specific bookmark in the model' do
      bookmark = Bookmark.create(url: 'http://www.testbookmark.com', title: 'Test Bookmark')
      result = Bookmark.find(id: bookmark.id)

      expect(result).to be_a Bookmark
      expect(result.id).to eq bookmark.id
      expect(result.title).to eq 'Test Bookmark'
      expect(result.url).to eq 'http://www.testbookmark.com'
    end
  end

  describe '.where' do
    it 'returns bookmarks with the given tag id' do
      bookmark = Bookmark.create(url: "http://www.makersacademy.com", title: 'Makers Academy')
      tag1 = Tag.create(content: 'test tag 1')
      tag2 = Tag.create(content: 'test tag 2')
      BookmarkTag.create(bookmark_id: bookmark.id, tag_id: tag1.id)
      BookmarkTag.create(bookmark_id: bookmark.id, tag_id: tag2.id)

      bookmarks = Bookmark.where(tag_id: tag1.id)
      result = bookmarks.first

      expect(bookmarks.length).to eq 1
      expect(result).to be_a Bookmark
      expect(result.id).to eq bookmark.id
      expect(result.title).to eq bookmark.title
      expect(result.url).to eq bookmark.url
    end
  end

  describe '.comments' do
    it 'calls .where on the Comment class' do
      bookmark = Bookmark.create(title: 'Makers Academy', url: 'http://www.makersacademy.com')
      expect(comment_class_double).to receive(:where).with(bookmark_id: bookmark.id)

      bookmark.comments(comment_class_double)
    end
  end

  describe '.tags' do
    it 'calls .where on the Tag class' do
      bookmark = Bookmark.create(title: 'Makers Academy', url: 'http://www.makersacademy.com')
      expect(tag_class_double).to receive(:where).with(bookmark_id: bookmark.id)

      bookmark.tags(tag_class_double)
    end
  end
end
