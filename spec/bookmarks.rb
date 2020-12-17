require 'database_helpers'
require 'bookmarks'

describe Bookmarks do
  describe '.create' do
    it 'creates a new bookmark' do
      bookmark = Bookmarks.create(url: 'http://www.testbookmark.com', title: 'Test Bookmark')
      persisted_data = persisted_data(id: bookmark.id)

      expect(bookmark).to be_a Bookmarks
      expect(bookmark.id).to eq persisted_data['id']
      expect(bookmark.title).to eq 'Test Bookmark'
      expect(bookmark.url).to eq 'http://www.testbookmark.com'
    end
  end

  describe '.delete' do
    it 'deletes a bookmark' do
      bookmark = Bookmarks.create(url: 'http://www.testbookmark.com', title: 'Test Bookmark')
      # persisted_data = persisted_data(id: bookmark.id)
      bookmark.delete(id: bookmark.id)

      expect { bookmark.all }.to change{ bookmarks.all.length}.by(0)
    end
  end
end
