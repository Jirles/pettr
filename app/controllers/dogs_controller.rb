class DogsController < ApplicationController

  def index
  end

  def show
    @dog = Dog.find(params[:id])

    redirect_to owner_dog_path(@dog) if @dog.owner == @current_user

    @pettings = @dog.pettings.most_recent
  end

end
