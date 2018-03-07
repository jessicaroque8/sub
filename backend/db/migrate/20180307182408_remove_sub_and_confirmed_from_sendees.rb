class RemoveSubAndConfirmedFromSendees < ActiveRecord::Migration[5.1]
  def change
     remove_column :sendees, :sub
     remove_column :sendees, :confirmed
  end
end
