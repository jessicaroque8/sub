class AddAwaitingConfirmToSubRequest < ActiveRecord::Migration[5.1]
  def change
     add_column :sub_requests, :awaiting_confirm, :boolean, default: false, null: false
  end
end
