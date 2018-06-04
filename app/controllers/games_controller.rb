class GamesController < ApplicationController
    before_action :game_exists, only: [:show, :edit, :destroy]
    before_action :set_game, only: [:show, :edit, :update, :destroy]
    before_action :signed_in_user, only: [:new, :edit, :update]
    #before_action :admin_user, only: [:destroy]
  
    def index
        @games = Game.all
    end
  
    def show
        @reviews = @game.reviews
    end
  
    def new
        @game = Game.new
    end
  
    def create
        @game = Game.new(game_params)
        if @game.save
            flash[:success] = "Game created successfully!"
            redirect_to @game
        else 
            flash[:alert] = "Game creation failed!"
            render 'new'
        end
    end

    def edit
    end
  
    def update
        if @game.update_attributes(game_params)
            flash[:success] = "Game updated successfully!"
            redirect_to @game
        else 
            flash[:alert] = "Game creation failed!"
            render 'new'
        end
    end

    def destroy
        @game.destroy
        flash[:success] = "Game successfully destroyed."
        redirect_to games_path
    end
  
private
    def set_game
      @game = Game.find(params[:id])
    end
    def game_params
      params.require(:game).permit(:title, :description, :cover_url, :year, :featured, :gameplay, :genre, :developer, :publisher, :platforms, :esrb)
    end
    def signed_in_user
        if !signed_in?
            flash[:failure] = "You must sign in first."
            redirect_to '/signin'
        end
    end
    def admin_user
        redirect_to home_index_path unless current_user.admin
    end
    def game_exists
        redirect_to home_index_path unless !Game.where(id: params[:id]).empty?
    end    
end
