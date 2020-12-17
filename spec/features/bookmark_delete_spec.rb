feature 'delete a bookmark' do
  scenario 'removes url/title from bookmark list' do
    Bookmarks.create(url: 'http://www.makersacademy.com', title: 'Makers Academy')
    visit('/bookmarks')
    expect(page).to have_link('Makers Academy', href: 'http://www.makersacademy.com')
    first('.bookmark').click_button 'Delete'
    expect(current_path).to eq '/bookmarks'

    expect(page).not_to have_link("Makers Academy", href: 'http://www.makersacademy.com')
  end
end
