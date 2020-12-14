feature "App" do
  scenario "Shows hello world" do
    visit('/')
    expect(page).to have_content("Hello World")
  end
end
