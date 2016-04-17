class UsersController < ApplicationController
    before_filter :ensure_log_in, only: [:show]
    layout 'ready', except: [:show]
    def new
        @user = User.new
    end 
    def create
        @user = User.new(user_params)
        flash[:success]= []
        if(@user.save)
            flash[:success] << "Welcome to StudentBook!"
            flash[:success] << "hi"
            redirect_to user_path(@user)
        else
            render :new
        end
    end

    def show
        @user = User.find(params[:id])
    end

    private 

    def user_params
        params.require(:user).permit( :name, :email, :password, :password_confirmation)
    end
    def ensure_log_in
        if logged_in? == false
            redirect_to login_path
        end
    end
end