class Api::DataController < ApplicationController
    skip_before_action :require_login, :set_current_user

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

    def create_comment
        @comment = Comment.create(comment_params)
        render json: @comment, status: 201
    end 

    private

    def comment_params
        params.permit(:petting_id, :content)
    end 

end 