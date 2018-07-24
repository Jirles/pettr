class PettingsController < ApplicationController
  before_action :set_petting, only: [:show, :edit, :update, :destroy]
  before_action :owner_permissions_check, only: [:edit, :update, :destroy]
  skip_before_action :require_login, only: [:index]

  def index
    resp = Faraday.get('http://localhost:3000/api/pettings')
    @resp = JSON.parse(resp.body)
  end

  def show
  end

  def new
    @errors = nil
    @petting = Petting.new
    @dogs = Dog.all
  end

  def create
    @petting = @current_user.pettings.build(petting_params)
    @petting.set_attributes_if_dog_exists
    if @petting.save
      update_dog_rating
      redirect_to petting_path(@petting)
    else
      @errors = @petting.errors
      @petting = Petting.new
      @dogs = Dog.all
      render :new
    end
  end

  def edit
    @dogs = Dog.all
    @errors = nil
  end

  def update
    @petting.update(petting_params) #=> updates fields
    @petting.set_attributes_if_dog_exists #=> takes care of dog attributes if a profile is chosen/changed
    if @petting.save
      update_dog_rating
      flash[:notice] = "Update successful!"
      redirect_to petting_path(@petting)
    else
      @errors = @petting.errors
      @dogs = Dog.all
      render :edit
    end
  end

  def destroy
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

  def update_dog_rating
    if @petting.dog_id
      Dog.find(@petting.dog_id).update_rating(@petting.pet_rating)
    end
  end

  def owner_permissions_check
    unless @petting.user_id == @current_user.id
      flash[:notice] = "Sorry, but you're not allowed to do that."
      redirect_to root_path
    end
  end

end
