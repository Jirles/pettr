class PettingsController < ApplicationController
  before_action :require_login, only: [:show, :new]

  def index
    @pettings = Petting.all
  end

  def show
    @petting = Petting.find(params[:id])
  end

  def new
    @user = User.find(session[:user_id])
    @petting = @user.pettings.build
    @dogs = Dog.all
  end

  def create
    raise params.inspect
  end

  private

  def petting_params
    params.require(:petting).permit(:user_id, :dog_id, :name, :breed, :location, :pet_rating, :description)
  end

end
