class Movie < ApplicationRecord
  validates_presence_of :title

  has_many :movie_searches
  has_many :searches, through: :movie_searches
end
