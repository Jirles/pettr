require 'byebug'
class PettingsController < ApplicationController
  skip_before_action :require_login, only: [:index]

  def index
    @pettings = Petting.all
  end

  def show
    set_petting
  end

  def new
    @petting = Petting.new
    @dogs = Dog.all
  end

  def create
    petting = @current_user.pettings.build(petting_params)
    petting.set_attributes_if_dog_exists
    if petting.save
      redirect_to petting_path(petting)
    else
      redirect_to new_petting_path
    end
  end

  def edit
    set_petting
    owner_permissions_check(@petting.user_id) #=> redirects to root path if check fails
    @dogs = Dog.all
  end

  def update
    set_petting
    owner_permissions_check(@petting.user_id) #=> redirects to root path if check fails
    @petting.update(petting_params) #=> updates fields
    @petting.set_attributes_if_dog_exists #=> takes care of dog attributes if a profile is chosen/changed
    if @petting.save
      flash[:notice] = "Update successful!"
      redirect_to petting_path(@petting)
    else
      flash[:notice] = "Record failed to update."
      redirect_to edit_petting_path(@petting)
    end
  end

  def destroy
    set_petting
    owner_permissions_check(@petting.user_id) #=> redirects to root path if check fails

    Petting.find(@petting.id).destroy
    flash[:notice] = "Record successfully deleted."
    redirect_to root_path
  end

  private

  def petting_params
    params.require(:petting).permit(:location, :pet_rating, :description, :dog_id, :name, :breed)
  end

  def set_petting
    @petting = Petting.find(params[:id])
  end

end
