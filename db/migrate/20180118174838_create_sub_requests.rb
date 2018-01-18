class CreateSubRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :sub_requests do |t|
      t.date :date
      t.string :class_name
      t.integer :class_id_mb
      t.text :note
      t.references :group, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
