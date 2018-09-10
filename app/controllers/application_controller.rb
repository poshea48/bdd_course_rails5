class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  rescue_from ActiveRecord::RecordNotFound, with: :resource_not_found
  
  protected
  
  def resource_not_found
    flash[:danger] = "That path does not exist"
    redirect_to root_path 
  end
  
end
