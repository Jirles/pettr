class DogsController < ApplicationController

  def index
    @dogs = Dog.all
  end

  def show
    @dog = Dog.find(params[:id])
    redirect_to_owner_dog_path_if_owner
    @pettings = @dog.pettings
  end

  private

  def redirect_to_owner_dog_path_if_owner
    redirect_to owner_dog_path(@dog) if @dog.owner == @current_user
  end

end
