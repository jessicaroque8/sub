class User < ApplicationRecord
  has_and_belongs_to_many :groups, :unique => true
  has_many :sendees
  has_many :sub_requests, through: :sendees
  has_many :responses, through: :sendees
end
