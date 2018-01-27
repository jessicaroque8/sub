class User < ApplicationRecord
  has_and_belongs_to_many :groups, :unique => true
  has_many :sendees
  has_many :sub_requests, through: :sendees
  has_many :replies, through: :sendees

  has_secure_password

  validates_presence_of :first_name, :last_name, :email, :password_digest

end
