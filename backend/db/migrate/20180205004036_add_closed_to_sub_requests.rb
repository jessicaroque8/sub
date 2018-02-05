class AddClosedToSubRequests < ActiveRecord::Migration[5.1]
  def change
     add_column :sub_requests, :closed, :boolean, default: false, null: false
  end
end
