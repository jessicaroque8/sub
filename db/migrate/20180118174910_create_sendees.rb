class CreateSendees < ActiveRecord::Migration[5.1]
  def change
    create_table :sendees do |t|
      t.boolean :sub
      t.references :sub_request, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
