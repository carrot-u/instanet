class User < ApplicationRecord
  has_many :users, class_name: 'User'
  belongs_to :team
  belongs_to :manager, class_name: 'User', optional: true

  validates :first_name, presence: true
  validates :first_name, length: { minimum: 2 }
  validates :last_name, presence: true
  validates :last_name, length: { minimum: 2 }
  validates :title, presence: true
  validates :title, length: { minimum: 2 }
  validates :is_manager, presence: true
  validates :active, presence: true

  validates_associated :users
  validates :manager, presence: true
  validates :team, presence: true

end
