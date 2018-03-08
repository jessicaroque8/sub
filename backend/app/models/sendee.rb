class Sendee < ApplicationRecord
  belongs_to :sub_request
  belongs_to :user
  has_one :reply
  has_one :selected_sub

  after_create :create_reply

  validates_presence_of :sub_request_id, :user_id

  private

  def create_reply
     Reply.create(sendee_id: self.id, sub_request_id: self.sub_request_id, value: 0, note: nil)
  end

end
