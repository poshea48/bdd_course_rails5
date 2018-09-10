require 'rails_helper'

RSpec.feature "Listing Articles" do 
  before do 
    @user = User.create(email: 'user@example.com', password: 'password')
    login_as(@user)
    @article1 = Article.create({ title: "Article 1",
                                 body: "Article 1 body",
                                 user: @user
                               })
    @article2 = Article.create({ title: "Article 2",
                                 body: "Article 2 body",
                                 user: @user
                               })
  end 
  
  scenario "A user lists all articles" do 
    visit "/"
    
    expect(page).to have_content(@article1.title) 
    expect(page).to have_content(@article1.body)
    expect(page).to have_content(@article2.title)
    expect(page).to have_content(@article2.body)
    expect(page).to have_link(@article1.title)
    expect(page).to have_link(@article2.title)
  end
  
  scenario "A user has no articles" do 
    Article.delete_all
    
    visit "/"
    
    expect(page).not_to have_content(@article1.title) 
    expect(page).not_to have_content(@article1.body)
    expect(page).not_to have_content(@article2.title)
    expect(page).not_to have_content(@article2.body)
    expect(page).not_to have_link(@article1.title)
    expect(page).not_to have_link(@article2.title)
    
    within ("h1#no-articles") do 
      expect(page).to have_content("No Articles created")
    end 
  end
  
  
end 