class Search < ApplicationRecord
  validates :criteria, presence: true, uniqueness: true
  has_many :movie_searches
  has_many :movies, through: :movie_searches
end
