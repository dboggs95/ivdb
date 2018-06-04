class ReviewsController < ApplicationController
    before_action :set_game, only: [:create, :update, :destroy]
    before_action :set_review, only: [:update, :destroy]
    before_action :signed_in_user, only: [:create]
    before_action :admin_or_correct_user, only: [:update, :destroy]

    def create
        @review = @game.reviews.create(review_params)
        if !@review.nil?
            flash[:success] = "Review created successfully!"
            redirect_to @game
        else 
            flash[:alert] = "Review creation failed!"
            redirect_to @game 
        end
    end

    def update
        if @review.update_attributes(review_params)
            flash[:success] = "Review updated."
            redirect_to @game
        else
            render @game
        end
    end
    
    def destroy
        @review.destroy
        flash[:success] = "Review successfully destroyed."
        redirect_to @game
    end

private
    def set_game
        @game = Game.find(params[:game_id])
    end
    def set_review
        @review = @game.reviews.find(params[:id])
    end
    def review_params
	    params.require(:review).permit(:title, :rating, :body, :user_id)
    end
    def signed_in_user
        if !signed_in?
            flash[:failure] = "You must sign in first."
            redirect_to '/signin'
        end
    end
    def admin_or_correct_user
        redirect_to home_index_path unless @review.user_id == current_user.id || current_user.admin
    end
end