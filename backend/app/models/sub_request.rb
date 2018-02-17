class SubRequest < ApplicationRecord
  belongs_to :group
  belongs_to :user
  has_many :sendees
  has_many :replies, through: :sendees

  after_create :send_to_sendees

  validates_presence_of :start_date_time
  validates_presence_of :end_date_time
  validates_presence_of :class_name
  validates_presence_of :class_id_mb

  def send_to_sendees
     group = Group.find(self.group_id)
     group.users.each do |user|
        if (user != self.user)
           Sendee.create!(user: user, sub_request: self, sub: false)
        end
     end
  end

end
