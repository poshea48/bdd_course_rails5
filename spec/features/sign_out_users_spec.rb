require "rails_helper"

RSpec.feature "User signs out" do 
  before do 
    @user = User.create(email: 'user@example.com', password: 'password')
    
    visit '/'
    click_link "Sign in"
    fill_in "Email", with: @user.email
    fill_in "Password", with: 'password'
    click_button 'Log in'
    
    expect(page).to have_content("Signed in as #{@user.email}")
  end
  
  scenario "user signs out successfully" do 
    visit '/'
    
    click_link "Sign out"
    
    expect(page).to have_content("Signed out successfully")
    expect(page).not_to have_link("Sign out")
    expect(page.current_path).to eq(root_path)
    
  end 
end 