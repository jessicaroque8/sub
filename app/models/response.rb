class Response < ApplicationRecord
  belongs_to :sendee
  belongs_to :sub_request
end
