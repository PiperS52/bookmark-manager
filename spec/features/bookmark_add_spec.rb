feature 'bookmark_add' do
  scenario 'adds url to bookmark list' do
    PG.connect(dbname: 'bookmark_manager_test')

    visit('/bookmarks/new')
    fill_in('url', with:'www.test.com')
    fill_in('title', with:'Test')
    click_button('Submit')

    expect(page).to have_content "Test"

  end
end

feature 'Adding a new bookmark' do
  scenario 'A user can add a bookmark to Bookmark Manager' do
    visit('/bookmarks/new')
    fill_in('url', with: 'http://www.testbookmark.com')
    fill_in('title', with: 'Test Bookmark')
    click_button('Submit')
    visit('/bookmarks')

    expect(page).to have_link('Test Bookmark', href: 'http://www.testbookmark.com')
  end
end
