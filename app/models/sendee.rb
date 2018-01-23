class Sendee < ApplicationRecord
  belongs_to :sub_request
  belongs_to :user
  has_one :reply
end
