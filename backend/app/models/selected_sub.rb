class SelectedSub < ApplicationRecord
   belongs_to :sub_request
   belongs_to :sendee

   before_create :set_default

   private

   def set_default
      self.confirmed = self.confirmed || false
   end

end
