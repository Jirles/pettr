class Owner::DogsController < ApplicationController
  before_action :set_dog, :authenticate_owner
  skip_before_action :set_dog, only: [:new, :create]
  skip_before_action :authenticate_owner, only: [:new, :create]

  def show
    @pettings = @dog.pettings
  end

  def edit
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
end
