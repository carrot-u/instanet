class UserBadge < ApplicationRecord
  belongs_to :user
  # Once logins are generated, track who issues the badge by login
  # belongs_to :issued_by, class_name: "User", foreign_key: "issued_by_id"

  validates :badge, presence: true, inclusion: { in: [1,2,3,4,5] }
  validates :description, presence: true
  
end
