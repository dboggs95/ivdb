class UsersController < ApplicationController
    before_action :user_exists, only: [:show, :edit, :destroy]
 before_action :set_user, only: [:show, :edit, :update, :destroy]
    before_action :signed_in_user, only: [:new, :create, :edit, :update, :index, :show]
    before_action :admin_user, only: [:index, :destroy]
    before_action :admin_or_correct_user, only: [:show, :edit]
    
    def index
        @users = User.all
    end
    
    def show
        @reviews = Review.where(user_id: @user.id)
    end
    
    def new
        @user = User.new
    end
    
    def create
        @user = User.new(user_params)#create a new user object with the parameters sent by the form
        if @user.save
            flash[:success] = "Account created successfully!"#if the User object saves successfully 
            sign_in @user
            redirect_to @user #redirects to the show action – executes the action and renders view
        else 
            flash[:alert] = "Account not created successfully, you need to make sure and follow email and password field rules"
            render 'new' #this will just render the new view if the user is not saved successfully (this usually means that the validations didn’t pass)
        end
    end
    
    def edit
    end
    
    def update
        if @user.update_attributes(user_params)
            flash[:success] = "Profile updated."
            redirect_to @user
        else
            render 'edit'
        end
    end
    
    def destroy
        @user.destroy
        flash[:success] = "#{@user.name} successfully destroyed."
        redirect_to users_path
    end
  
private 
    def set_user
        @user = User.find(params[:id])
    end
    def user_params
	    params.require(:user).permit(:name, :email, :admin, :password, :password_confirmation)
    end
    def signed_in_user
        if !signed_in?
            flash[:failure] = "You must sign in first."
            redirect_to '/signin'
        end
    end
    def correct_user
        @user = User.find(params[:id])
        redirect_to home_index_path unless current_user?(@user)
    end
    def admin_user
        redirect_to home_index_path unless current_user.admin
    end
    def admin_or_correct_user
        @user = User.find(params[:id])
        redirect_to home_index_path unless (current_user.id == @user.id || current_user.admin)
    end
    def user_exists
        redirect_to home_index_path unless !User.where(id: params[:id]).empty?
    end
end
