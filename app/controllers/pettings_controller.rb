class PettingsController < ApplicationController
  before_action :require_login, only: [:show]

  def index
    @pettings = Petting.all
  end

  def show
    @petting = Petting.find(params[:id])
  end
  
end
