class CreateSubscribers < ActiveRecord::Migration[5.1]
  def change
    create_table :subscribers do |t|
      t.boolean :initiator
      t.boolean :sub
      t.references :sub_request, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
