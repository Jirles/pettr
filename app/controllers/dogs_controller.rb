class DogsController < ApplicationController
  before_action :require_login

  def index
    @dogs = Dog.all
  end

  def show
    @dog = Dog.find(params[:id])
    @pettings = @dog.pettings
  end

end
