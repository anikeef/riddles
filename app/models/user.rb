class User < ApplicationRecord
  has_secure_password
  has_many :problems
  mount_uploader :avatar, AvatarUploader
  validates :name, presence: true, length: {maximum: 30}, uniqueness: {case_sensitive: true}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true,
            format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  validates :password, presence: true, length: {minimum: 6}

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
end
