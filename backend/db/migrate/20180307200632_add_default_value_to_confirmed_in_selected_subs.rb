class AddDefaultValueToConfirmedInSelectedSubs < ActiveRecord::Migration[5.1]
  def change
     change_column :selected_subs, :confirmed, :boolean, default: false
  end
end
