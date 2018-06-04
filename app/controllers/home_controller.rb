class HomeController < ApplicationController
  def index
    @games = Game.all
    games_user_pick = Array.new
    
    @games.each do |game|
      rating = get_rating(game)
      if !rating.nil? && rating >= 9
        games_user_pick << game
      end
    end
    
    @games_user_pick = games_user_pick
    @games_featured = Game.where(featured: true)
  end

  def help
  end

  def about
  end

  def contact
  end
end
