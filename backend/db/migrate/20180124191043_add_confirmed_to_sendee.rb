class AddConfirmedToSendee < ActiveRecord::Migration[5.1]
  def change
     add_column :sendees, :confirmed, :boolean
  end
end
