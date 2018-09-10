require 'rails_helper'

RSpec.feature "Deleting an Article" do 
  before do
    @user = User.create(email: 'user@example.com', password: 'password')
    login_as(@user)
    @article = Article.create(title: "Title One", body: "Body of article one")
    @article.user = current_user
    
  end
  
  scenario "A user deletes article" do 
    visit "/"
    click_link @article.title 
    
    click_link "Delete Article"
    
    expect(page).to have_content("Article has been deleted")
    expect(page.current_path).to eq(articles_path)
  end
end 