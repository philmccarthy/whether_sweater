class User < ApplicationRecord
  has_secure_token :api_key
  has_secure_password
  validates :email, uniqueness: true, presence: true
  validates :password_confirmation, presence: true
  validates_confirmation_of :password
end
