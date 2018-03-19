class SubRequest < ApplicationRecord
  belongs_to :group
  belongs_to :user
  has_many :sendees
  has_many :replies, through: :sendees
  has_one :selected_sub

  after_create :send_to_sendees

  validates_presence_of :start_date_time
  validates_presence_of :end_date_time
  validates_presence_of :class_name
  validates_presence_of :class_id_mb

  scope :unresolved, -> { where('closed = ? AND start_date_time >= ?', false, Time.now.to_date) }
  scope :resolved, -> { where('closed = ? AND start_date_time >= ?', true, Time.now.to_date) }
  scope :past, -> { where('start_date_time < ?', Time.now.to_date)}

  def send_to_sendees
     group = Group.find(self.group_id)
     group.users.each do |user|
        if (user != self.user)
           Sendee.create!(user: user, sub_request: self)
        end
     end
  end

end
