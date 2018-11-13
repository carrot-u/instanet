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
  validates :is_manager, inclusion: { in: [ true, false ] }
  validates :active, inclusion: { in: [ true, false ] }

  validates_associated :users
  validates :team, presence: true

end
