require 'database_helpers'
require './lib/bookmarks'

describe Bookmark do
  describe '.create' do
    it 'creates a new bookmark' do
      bookmark = Bookmark.create(url: 'http://www.testbookmark.com', title: 'Test Bookmark')
      persisted_data = persisted_data(id: bookmark.id)
      Bookmark.create(url: 'http://www.destroyallsoftware.com', title: 'Destroy All Software')


      expect(bookmark).to be_a Bookmark
      expect(bookmark.id).to eq persisted_data['id']
      expect(bookmark.title).to eq 'Test Bookmark'
      expect(bookmark.url).to eq 'http://www.testbookmark.com'
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
end
