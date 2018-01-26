class AddDefaultValueToHasRepliedAttribute < ActiveRecord::Migration[5.1]
  def change
     change_column :sendees, :has_replied, :boolean, default: false
  end
end
