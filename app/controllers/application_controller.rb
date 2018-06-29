class ApplicationController < ActionController::Base

  def home
  end

  private
  def logged_in?
    !!session[:user_id]
  end
  
  def require_login
    redirect_to root_path if !logged_in?
  end

end
