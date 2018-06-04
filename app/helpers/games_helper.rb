module GamesHelper
    def get_rating(game)
       reviews = game.reviews
       sum = 0.to_i
       total = 0.to_i
       reviews.each do |review|
           sum += review.rating.to_i
           total += 1.to_i
       end
       if total == 0
           nil
       else
           sum / total
       end
    end
end
