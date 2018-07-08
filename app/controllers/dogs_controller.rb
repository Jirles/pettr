class DogsController < ApplicationController

  def index
    @dogs = Dog.all
  end

  def show
    @dog = Dog.find(params[:id])

    redirect_to owner_dog_path(@dog) if @dog.owner == @current_user

    @pettings = @dog.pettings
  end

end
