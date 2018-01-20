class SubRequest < ApplicationRecord
  belongs_to :group
  belongs_to :user
  has_many :sendees
  has_many :responses, through: :sendees
end
