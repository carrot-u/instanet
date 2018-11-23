class Team < ApplicationRecord
  has_many :teams, class_name: 'Team'
  has_many :users, class_name: 'User'
  belongs_to :manager, class_name: 'User', optional: true
  belongs_to :parent_team, class_name: 'Team', optional: true

  validates :name, presence: true
  validates :name, length: { minimum: 2 }
  validates :active, inclusion: { in: [ true, false ] }
  validates :is_parent, inclusion: { in: [ true, false ] }

  validates_associated :users, :teams, :manager, :parent_team, allow_nil: true

end
