class Api::DataController < ApplicationController
    skip_before_action :require_login

    def pettings
        @pettings ||= Petting.most_recent
        render json: @pettings, status: 200  
    end 

    def petting
        @petting ||= Petting.find(params[:id])
        render json: @petting, status: 200
    end 

    def dogs
        @dogs ||= Dog.all
        render json: @dogs, status: 200  
    end 

    def dog
        @dog ||= Dog.find(params[:id])
        render json: @dog, status: 200
    end 

    def user 
        @user ||= User.find(params[:id])
        render json: @user, status: 200
    end 

    def comments
        # create a new comment
    end 
end 