class PettingsController < ApplicationController
  before_action :require_login, only: [:show, :new]

  def index
    @pettings = Petting.all
  end

  def show
    @petting = Petting.find(params[:id])
  end

  def new
    @petting = @current_user.pettings.build
  end

  def create
    raise params.inspect
  end

end
