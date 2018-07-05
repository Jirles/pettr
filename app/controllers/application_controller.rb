class ApplicationController < ActionController::Base
  before_action :set_current_user

  def home
  end

  private
  def logged_in?
    !!session[:user_id]
  end

  def require_login
    if !logged_in?
      flash[:notice] = "Please login or signup to view more content."
      redirect_to login_path
    end
  end

  def set_current_user
    @current_user = User.find_by(id: session[:user_id]) #=> fails gracefully (@current_user set to nil)
  end

  def owner_permissions_check(user_id)
    if user_id != @current_user.id
      flash[:notice] = "Sorry, but you're not allowed to do that."
      redirect_to root_path
    end
  end

end
