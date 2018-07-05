require 'byebug'
class PettingsController < ApplicationController
  before_action :require_login, only: [:show, :new, :create]

  def index
    @pettings = Petting.all
  end

  def show
    @petting = Petting.find(params[:id])
  end

  def new
    @petting = Petting.new
    @dogs = Dog.all
  end

  def create
    @user = User.find(session[:user_id])
    petting = @user.pettings.build(petting_params)
    petting.set_attributes_if_dog_exists
    if petting.save
      redirect_to petting_path(petting)
    else
      redirect_to new_petting_path
    end
  end

  def edit
    @petting = Petting.find(params[:id])
    @dogs = Dog.all
  end

  def update

  end

  private

  def petting_params
    params.require(:petting).permit(:location, :pet_rating, :description, :dog_id, :name, :breed)
  end

end
