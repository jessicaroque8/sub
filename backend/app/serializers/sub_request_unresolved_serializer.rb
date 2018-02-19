class SubRequestUnresolvedSerializer < SubRequestSerializer
  attributes :id, :start_date_time, :end_date_time, :class_name,
   :class_id_mb, :note, :closed, :awaiting_confirm, :created_at,
   :agree_count

   belongs_to :group, serializer: GroupNameSerializer
   belongs_to :user
   has_many :sendees

   def agree_count
      byebug
      count = 0
      object.sendees.each do |sendee|
         sendee.reply.value == 'agree' ? count += 1 : next
      end
      count
   end
end
