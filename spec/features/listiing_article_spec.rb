require 'rails_helper'

RSpec.feature "Listing Articles" do 
  before do 
    @article1 = Article.create({ title: "Article 1",
                                 body: "Article 1 body"
                               })
    @article2 = Article.create({ title: "Article 2",
                                 body: "Article 2 body"
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
end 