class AddAwaitingConfirmToSubRequests < ActiveRecord::Migration[5.1]
  def change
    add_column :sub_requests, :awaiting_confirm, :boolean, default: false
  end
end
