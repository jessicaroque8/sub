class Sendee < ApplicationRecord

  include ActiveModel::Dirty

  belongs_to :sub_request
  belongs_to :user
  has_one :reply

  after_create :create_reply
  after_save :check_state

  validates_presence_of :sub_request_id, :user_id

  private

  def create_reply
     Reply.create(sendee_id: self.id, sub_request_id: self.sub_request_id, value: 0, note: nil)
  end

  def check_state
     if self.sub_changed?
         if self.sub_was = false && self.sub == true
            self.confirmed = false
         end
      end
   end


end
