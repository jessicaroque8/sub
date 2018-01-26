class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.integer :staff_id_mb
      t.string :first_name
      t.string :last_name

      t.timestamps
    end
  end
end
