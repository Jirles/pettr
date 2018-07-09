class Owner::DogsController < ApplicationController
  before_action :set_dog, :authenticate_owner
  skip_before_action :set_dog, only: [:new, :create]
  skip_before_action :authenticate_owner, only: [:new, :create]

  def show
    @pettings = @dog.pettings.most_recent
  end

  def new
    @dog = Dog.new
    @errors = nil
  end

  def create
    @dog = Dog.create(dog_params)
    if @dog.valid?
      PetAccount.create(:user_id => @current_user.id, :dog_id => @dog.id)
      redirect_to owner_dog_path(@dog)
    else
      @errors = @dog.errors
      @dog = Dog.new
      render :new
    end
  end

  def edit
    @errors = nil
  end

  def update
    if @dog.update(dog_params)
      flash[:notice] = "Profile successfully updated!"
      redirect_to owner_dog_path(@dog)
    else
      @errors = @dog.errors
      render :new
    end
  end

  def destroy
    Dog.find(@dog.id).destroy
    flash[:notice] = "#{@dog.name}'s profile was succesfully deleted."
    redirect_to dogs_path
  end

  private

  def set_dog
    @dog = Dog.find(params[:id])
  end

  def authenticate_owner
    unless @dog.owner == @current_user
      flash[:notice] = "Sorry, but you do not have access to that page."
      redirect_to dogs_path
    end
  end

  def dog_params
    params.require(:dog).permit(:name, :breed, :age, :city, :bio)
  end
end
