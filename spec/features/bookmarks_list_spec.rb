feature 'Bookmarks' do 
    scenario 'showing a list of book marks' do 
        visit('/bookmarks') 
        expect(page).to have_content("list")
    end 
end 