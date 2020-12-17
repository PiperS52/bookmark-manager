feature 'update a bookmark' do
  scenario 'updates url/title from bookmark list' do
    bookmark = Bookmark.create(url: 'http://www.makersacademy.com', title: 'Makers Academy')
    visit('/bookmarks')
    expect(page).to have_link('Makers Academy', href: 'http://www.makersacademy.com')
    first('.bookmark').click_button 'Edit'
    expect(current_path).to eq "/bookmarks/#{bookmark.id}/edit"


    fill_in('url', with:'http://www.test.com')
    fill_in('title', with:'Test')

    click_button('Submit')
    expect(current_path).to eq '/bookmarks'

    expect(page).not_to have_link("Makers Academy", href: 'http://www.makersacademy.com')
    expect(page).to have_link("Test", href: 'http://www.test.com')
  end
end
