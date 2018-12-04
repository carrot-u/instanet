class UserBadge < ApplicationRecord
  belongs_to :user
  # Once logins are generated, track who issues the badge by login
  # belongs_to :issued_by, class_name: "User", foreign_key: "issued_by_id"

end
