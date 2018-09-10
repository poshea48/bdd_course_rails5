require 'rails_helper'

RSpec.feature "Show article" do 
  before do
    @user = User.create(email: 'user@example.com', password: 'password')
    login_as(@user)
    @article = Article.create(title: "Title One", body: "Body of article one", user: @user)
  end 
  
  scenario "a user shows an article" do
    visit "/"
    click_link @article.title
    
    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(current_path).to eq(article_path(@article))
  end 
end 