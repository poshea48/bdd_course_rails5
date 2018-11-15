require 'rails_helper'

RSpec.describe "Comments", type: :request do 
  
  before do 
    @user1 = User.create(email: 'user1@example.com', password: 'password1')
    @user2 = User.create(email: 'user2@example.com', password: 'password2')
    
    @article = Article.create!(title: "Title One", body: "Body of article one", user: @user1)
  end 
  
  describe 'POST /articles/:id/comments' do 
    context 'with a non signed-in user' do 
      before do 
        post "/articles/#{@article.id}/comments", params: { comment: {body: "Awesome blog"}}
      end 
    
      it "redirect user to the signin page" do 
        flash_message = "Please sign in or sign up first"
        expect(response).to redirect_to(new_user_session_path)
        expect(response.status).to eq 302
        expect(flash[:danger]).to eq flash_message 
      end 
    end
    
    context 'with a logged in user' do 
      before do 
        login_as(@user1)
        post "/articles/#{@article.id}/comments", params: { comment: {body: "Awesome blog"}}
      end 
      
      it "create the comment successfully" do
        flash_message = "Your comment has been added"
        expect(response).to redirect_to(article_path(@article.id))
        expect(response.status).to eq 302
        expect(flash[:success]).to eq flash_message
      end 
    end 
  end 
end 
  