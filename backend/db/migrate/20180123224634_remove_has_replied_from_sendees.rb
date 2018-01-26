class RemoveHasRepliedFromSendees < ActiveRecord::Migration[5.1]
  def change
    remove_column :sendees, :has_replied, :boolean
  end
end
