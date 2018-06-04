class Game < ApplicationRecord
    searchable do
        text :title, :description, :developer, :publisher, :platforms, :gameplay, :genre
    end
    validates :title, presence: true, length: {maximum: 50}
    validates :description, presence: true, length: {maximum: 500}
    has_many :reviews, dependent: :destroy
end