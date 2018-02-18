class SubRequestSerializer < ActiveModel::Serializer
  attributes :id, :start_date_time, :end_date_time, :class_name,
   :class_id_mb, :note, :closed, :awaiting_confirm, :created_at

   belongs_to :group
   belongs_to :user
   has_many :sendees
end
