class CommentsController < ApplicationController
  before_action :set_article
  
  def create
    @comment = @article.comments.build(comment_params)
    @comment.user = current_user
    
    if @comment.save
      flash[:success] = "Your comment has been added"
      redirect_to article_path(@article)
    else 
      flash[:danger] = "Your comment was not added"
      render 'articles/show'
    end
  end 
  
  private
    
    def comment_params
      params.require(:comment).permit(:body)
    end 
    
    def set_article
      @article = Article.find(params[:article_id])
    end 
end
