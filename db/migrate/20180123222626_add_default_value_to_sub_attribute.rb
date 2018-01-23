class AddDefaultValueToSubAttribute < ActiveRecord::Migration[5.1]
  def change
       change_column :sendees, :sub, :boolean, default: false
  end
end
