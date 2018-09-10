require 'rails_helper'

RSpec.feature "Show article" do 
  before do
    @user1 = User.create(email: 'user1@example.com', password: 'password1')
    @user2 = User.create(email: 'user2@example.com', password: 'password2')
    
    @article = Article.create(title: "Title One", body: "Body of article one", user: @user1)
  end 
  
  scenario "to a signed in user" do
    login_as(@user1)
    visit "/"
    click_link @article.title
    
    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(current_path).to eq(article_path(@article))
    
    expect(page).to have_link("Edit Article")
    expect(page).to have_link("Delete Article")
  end
  
  scenario "to a non-signed in user hide the Edit and Delete links" do
    visit "/"
    click_link @article.title
    
    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(current_path).to eq(article_path(@article))
    
    expect(page).not_to have_link("Edit Article")
    expect(page).not_to have_link("Delete Article")
  end 
  
  scenario "to a non-owner in user hide the Edit and Delete links" do
    login_as(@user2)
    
    visit "/"
    click_link @article.title
    
    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(current_path).to eq(article_path(@article))
    
    expect(page).not_to have_link("Edit Article")
    expect(page).not_to have_link("Delete Article")
  end 
end 