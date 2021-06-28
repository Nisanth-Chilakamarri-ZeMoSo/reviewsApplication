class Book < ApplicationRecord
    validates :title, presence: true, uniqueness: {case_sensitive: false}
    validates :author, presence: true
    validates :rating, presence: true
    scope :filter_by_starts_with, -> ( title ) { where("title like ?", "#{title}%")}
end