class Response < ApplicationRecord
  belongs_to :subscriber
  belongs_to :sub_request
end
