class User < ApplicationRecord
  has_many :users, class_name: 'User'
  belongs_to :team
  belongs_to :manager, class_name: 'User', optional: true

  validates :first_name, presence: true, length: { minimum: 2 }
  validates :last_name, presence: true, length: { minimum: 2 }
  validates :title, presence: true, length: { minimum: 2 }
  validates :is_manager, inclusion: { in: [ true, false ] }
  validates :active, inclusion: { in: [ true, false ] }
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/, message: "Must be a valid e-mail format" }
  validates :slack, presence: true, uniqueness: { case_sensitive: false }, format: { with: /\A[a-z0-9][a-z0-9._-]*\z/, message: "Must be a valid slack username format" }
  validates :started_at, presence: true
  validates :team, presence: true

  validates_associated :users, :manager, allow_nil: true
  validates_associated :team

  def full_name
    "#{first_name} #{last_name}"
  end

end
