class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create, :facebook]

  def new
  end

  def facebook
    raise auth.inspect
    @user = User.find_by_or_create_from_auth_hash(auth)
    if @user.valid?

    else
      flash[:notice] = "There was an issue accessing your information from Facebook."
      redirect_back(:allow_other_host => false)
    end
  end

  def create
    @user = User.find_by(email: params[:session][:email])
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      flash[:notice] = "Email/password can't be blank."
      redirect_to login_path
    end
  end

  def destroy
    session.clear
    redirect_to root_path
  end

  private

  def auth
    request.env['omniauth.auth']
  end

end
