class SubRequestSerializer < ActiveModel::Serializer
  attributes :id, :start_date_time, :end_date_time, :class_name,
   :class_id_mb, :note, :closed, :created_at, :selected_sub

   belongs_to :group
   belongs_to :user
   has_many :sendees
   has_one :selected_sub
end
