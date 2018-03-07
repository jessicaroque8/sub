class RemoveAwaitingConfirmFromSubRequests < ActiveRecord::Migration[5.1]
  def change
     remove_column :sub_requests, :awaiting_confirm
  end
end
