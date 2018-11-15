require "rails_helper"

RSpec.feature "Adding comments to Articles" do 
  before do
    @user1 = User.create(email: 'user1@example.com', password: 'password1')
    @user2 = User.create(email: 'user2@example.com', password: 'password2')
    
    @article = Article.create(title: "Title One", body: "Body of article one", user: @user1)
  end 
  
  scenario "permits a signed in user to make a comment" do 
    login_as(@user1)
    visit '/'
    
    click_link @article.title
    fill_in "New Comment", with: "This is a comment"
    click_button "Add Comment"
    
    expect(page).to have_content("Your comment has been added")
    expect(page).to have_content("This is a comment")
    expect(current_path).to eq(article_path(@article.id))
  end
  
  # scenario "non-signed in user tries to make a comment" do
  #   visit '/'
  #   expect(page).to have_content("Sign in")
    
  #   click_link @article.title
  #   fill_in "New Comment", with: "This is a comment"
  #   click_button "Add Comment"
    
  #   expect(page).to have_content("You must be signed in to make a comment")
  #   expect(current_path).to eq(new_user_session_path)
  # end 
end 