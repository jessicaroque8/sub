class SelectedSub < ApplicationRecord
   belongs_to :sub_request
   belongs_to :sendee

   before_create :set_default
   after_save :check_confirmed

   private

   def set_default
      self.confirmed = self.confirmed || false
   end

   def check_confirmed
      if self.confirmed == true
         self.sub_request.closed = true
         self.sub_request.save!
      end
   end 

end
