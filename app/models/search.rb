class Search < ApplicationRecord
  validates :search_term, presence: true
end
