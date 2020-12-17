require 'database_helpers'
require 'bookmarks'

describe Bookmark do
  describe '.create' do
    xit 'creates a new bookmark' do
      bookmark = Bookmark.create(url: 'http://www.testbookmark.com', title: 'Test Bookmark')
      # persisted_data = persisted_data(id: bookmark.id)
      Bookmark.create(url: 'http://www.destroyallsoftware.com', title: 'Destroy All Software')

      expect(bookmark).to be_a Bookmark
      expect(bookmark.id).to eq persisted_data['id']
      expect(bookmark.title).to eq 'Test Bookmark'
      expect(bookmark.url).to eq 'http://www.testbookmark.com'
    end
  end

  describe '.delete' do
    it 'deletes a bookmark' do
      Bookmark.create(url: 'http://www.testbookmark.com', title: 'Test Bookmark')
      # persisted_data = persisted_data(id: bookmark.id)
      Bookmark.delete(id: bookmark.id)

      expect(Bookmark.all.length).to eq(0)
    end
  end
end
