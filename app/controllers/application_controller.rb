class ApplicationController < ActionController::Base
  before_action :set_current_user

  def home
  end

  private
  def logged_in?
    !!session[:user_id]
  end

  def require_login
    redirect_to root_path if !logged_in?
  end

  def set_current_user
    @current_user = User.find(session[:user_id]) unless !logged_in?
  end

end
