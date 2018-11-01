class User < ApplicationRecord
  has_many :users, class_name: 'User'
  belongs_to :team
  belongs_to :manager, class_name: 'User', optional: true
end
