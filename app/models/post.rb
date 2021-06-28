class Post < ApplicationRecord
    validates :review, presence: true
    belongs_to :user
    belongs_to :category
    has_many :comments, dependent: :destroy
end