class Owner::DogsController < ApplicationController

  def show
    set_dog
    authenticate_owner
    @pettings = @dog.pettings
  end

  private

  def set_dog
    @dog = Dog.find(params[:id])
  end

  def authenticate_owner
    if @dog.owner_id != @current_user.id
      flash[:notice] = "Sorry, but you do not have access to that page."
      redirect_to dogs_path
    end 
  end
end
