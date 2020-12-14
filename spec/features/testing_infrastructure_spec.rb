feature "App" do
  scenario "Shows hello world" do
    visit('/')
    expect(page).to have_content("Hello World")
  end 

  scenario "should return a /bookmark route" do  
    visit('/bookmarks') 
    expect(page).to have_content("")
  end 
end 


