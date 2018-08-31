require 'rails_helper'

RSpec.feature "User sign in" do
  before do 
    @user = User.create(email: 'user@example.com', password: 'password')
  end
  
  scenario "User signs in with valid credentials" do 
    visit '/'
    click_link "Sign in"
    
    fill_in "Email", with: @user.email 
    fill_in "Password", with: @user.password
    click_button "Log in"
    
    expect(page).to have_content("Signed in successfully")
    expect(page).to have_content("Signed in as #{@user.email}")
    expect(page).not_to have_link("Sign in")
    expect(page).not_to have_link("Sign up")
  
  end 
  
  # scenario "User signs in unsuccessfully" do 
  #   visit '/'
  #   click_link "Sign in"
  #   fill_in "Email", with: "" 
  #   fill_in "Password", with: "" 
    
  #   expect(page).to have_content("You have not been signed in")
  # end 
    
end 