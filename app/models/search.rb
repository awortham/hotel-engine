class Search < ApplicationRecord
  validates :criteria, presence: true, uniqueness: true
end
