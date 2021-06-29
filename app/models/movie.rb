class Movie < ApplicationRecord
    validates :title, presence: true, uniqueness: {case_sensitive: false}
    validates :director, presence: true
    validates :rating, presence: true,
                            numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 10 }
    has_many :posts, as: :commentable, dependent: :destroy
    scope :filter_by_starts_with, -> (title) { where(" title like ?", "#{title}%")}
end