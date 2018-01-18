class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.integer :staff_id_mb

      t.timestamps
    end
  end
end
