class AddDefaultValueToValueAttribute < ActiveRecord::Migration[5.1]
  def change
     change_column :replies, :value, :integer, default: 0, null: false
  end
end
