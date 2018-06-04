class Review < ApplicationRecord
    belongs_to :game
    validates :title, presence: true, length: {maximum: 50}
    validates :body, presence: true, length: {maximum: 500}
end
