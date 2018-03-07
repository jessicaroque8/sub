class SubRequestUnresolvedSerializer < SubRequestSerializer
  attributes :id, :start_date_time, :end_date_time, :class_name,
   :class_id_mb, :note, :closed, :created_at,
   :reply_counts

   belongs_to :group
   belongs_to :user
   has_many :sendees

   def reply_counts
      counts = {
         agree: 0,
         maybe: 0,
         decline: 0,
         no_reply: 0
      }

      object.sendees.each do |sendee|
         case sendee.reply.value
            when 'agree'
               counts[:agree] += 1
            when 'maybe'
               counts[:maybe] += 1
            when 'decline'
               counts[:decline] += 1
            when 'no_reply'
               counts[:no_reply] += 1
         end
      end
      counts
   end
end
