class UserSkill < ApplicationRecord
  belongs_to :user

  validates :name, presence: true, length: { maximum: 60 }
  validates :level, presence: true, inclusion: { in: [1,2,3,4,5] }

  def white_stars
    5 - level
  end
end
