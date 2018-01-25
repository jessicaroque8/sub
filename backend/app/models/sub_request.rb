class SubRequest < ApplicationRecord
  belongs_to :group
  belongs_to :user
  has_many :sendees
  has_many :replies, through: :sendees

  validates_presence_of :start_date_time
  validates_presence_of :end_date_time
  validates_presence_of :class_name
  validates_presence_of :class_id_mb
end
