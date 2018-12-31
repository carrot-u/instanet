class User < ApplicationRecord
  has_many :users, class_name: 'User'
  has_many :user_badges
  has_many :user_skills
  belongs_to :team
  belongs_to :manager, class_name: 'User', optional: true

  validates :first_name, presence: true, length: { minimum: 2 }
  validates :last_name, presence: true, length: { minimum: 2 }
  validates :title, presence: true, length: { minimum: 2 }
  validates :is_manager, inclusion: { in: [ true, false ] }
  validates :active, inclusion: { in: [ true, false ] }
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/, message: "Must be a valid e-mail format" }
  validates :slack, presence: true, uniqueness: { case_sensitive: false }, format: { with: /\A[a-z0-9][a-z0-9._-]*\z/, message: "Must be a valid slack username format. Don't include the @!" }
  validates :started_at, presence: true
  validates :team, presence: true

  validates_associated :team

  def full_name
    "#{first_name} #{last_name}"
  end

  def self.find_or_create_from_auth_hash(auth)
    where(email: auth.info.email).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.google_id = auth.uid
      user.email = auth.info.email
      user.save!(validate: false)
    end
  end

  # def self.find_or_create_from_auth_hash(auth)
  #   where(provider: auth.provider, google_id: auth.uid).first_or_initialize.tap do |user|
  #     unless User.find_by(email: auth.info.email).nil?
  #       user = User.find_by(email: auth.info.email)
  #     end
  #     user.provider = auth.provider
  #     user.google_id = auth.uid
  #     user.email = auth.info.email
  #     user.save!(validate: false)
  #   end
  # end

end
