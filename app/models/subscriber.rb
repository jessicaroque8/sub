class Subscriber < ApplicationRecord
  belongs_to :sub_request
  belongs_to :user
end
