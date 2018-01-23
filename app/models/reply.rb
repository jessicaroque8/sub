class Reply < ApplicationRecord
  belongs_to :sendee
  belongs_to :sub_request
end
