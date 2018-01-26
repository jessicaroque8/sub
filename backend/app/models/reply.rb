class Reply < ApplicationRecord
  belongs_to :sendee
  belongs_to :sub_request

  validates_presence_of :sendee_id, :sub_request_id

  enum value: { "no_reply": 0, "agree": 1, "maybe": 2, "decline": 3 }

end
