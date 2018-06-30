class PettingsController < ApplicationController

  def index
    @pettings = Petting.all
  end

  def show
  end 
end
