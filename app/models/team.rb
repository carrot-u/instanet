class Team < ApplicationRecord
  has_many :teams, class_name: 'Team'
  has_many :users, class_name: 'User'
  belongs_to :manager, class_name: 'User', optional: true
  belongs_to :parent_team, class_name: 'Team', optional: true
end
